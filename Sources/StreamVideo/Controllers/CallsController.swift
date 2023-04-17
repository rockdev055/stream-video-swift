//
// Copyright © 2023 Stream.io Inc. All rights reserved.
//

import Foundation

/// Controller used for querying and watching calls.
public class CallsController: ObservableObject {
    
    /// Observable list of calls.
    @Published public var calls = [CallData]()
    
    actor State {
        var loading = false
        var loadedAllCalls = false
        
        func update(loading: Bool) {
            self.loading = loading
        }
        
        func update(loadedAllCalls: Bool) {
            self.loadedAllCalls = loadedAllCalls
        }
    }
    
    private let coordinatorClient: CoordinatorClient
    
    private var next: String?
    private var prev: String?
        
    private let state = State()
    
    private let callsQuery: CallsQuery
    private let streamVideo: StreamVideo
    
    private var watchTask: Task<Void, Error>?
    private var socketDisconnected = false
    
    init(streamVideo: StreamVideo, coordinatorClient: CoordinatorClient, callsQuery: CallsQuery) {
        self.coordinatorClient = coordinatorClient
        self.callsQuery = callsQuery
        self.streamVideo = streamVideo
        self.subscribeToWatchEvents()
    }
    
    /// Loads the next page of calls.
    public func loadNextCalls() async throws {
        try await loadCalls()
    }
    
    public func cleanUp() {
        watchTask?.cancel()
        watchTask = nil
    }
    
    // MARK: - private
    
    private func loadCalls(shouldRefresh: Bool = false) async throws {
        let isLoading = await state.loading
        let loadedAllCalls = await state.loadedAllCalls
        if isLoading || loadedAllCalls {
            return
        }
        await state.update(loading: true)
                
        let request = makeQueryCallsRequest()
        
        do {
            let response = try await coordinatorClient.queryCalls(request: request)
            if response.next == nil {
                await state.update(loadedAllCalls: true)
            }
            prev = response.prev
            next = response.next
            let calls = response.calls.map {
                CallData(
                    callCid: $0.call.cid,
                    members: $0.members.map { $0.user.toUser },
                    createdAt: $0.call.createdAt,
                    backstage: $0.call.backstage,
                    broadcasting: $0.call.broadcasting,
                    recording: $0.call.recording,
                    updatedAt: $0.call.updatedAt
                )
            }
            if shouldRefresh {
                self.calls = calls
            } else {
                self.calls.append(contentsOf: calls)
            }
            await state.update(loading: false)
        } catch {
            log.error("Error querying calls \(error.localizedDescription)")
            await state.update(loading: false)
            throw error
        }
    }
    
    private func makeQueryCallsRequest() -> QueryCallsRequest {
        let sortParams = makeSortParamsRequest()
        let filterConditions = makeFilterConditions()
        
        let request = QueryCallsRequest(
            filterConditions: filterConditions,
            limit: callsQuery.pageSize,
            next: next,
            prev: prev,
            sort: sortParams,
            watch: callsQuery.watch
        )
        return request
    }
    
    private func makeSortParamsRequest() -> [SortParamRequest] {
        var sortParams = [SortParamRequest]()
        for sortParam in callsQuery.sortParams {
            let param = SortParamRequest(
                direction: sortParam.direction.rawValue,
                field: sortParam.field.rawValue
            )
            sortParams.append(param)
        }
        return sortParams
    }
    
    private func makeFilterConditions() -> [String: AnyCodable]? {
        var filterConditions: [String: AnyCodable]?
        if let filters = callsQuery.filters {
            filterConditions = [String: AnyCodable]()
            for (key, filter) in filters {
                filterConditions?[key] = AnyCodable(filter)
            }
        }
        return filterConditions
    }
    
    private func handle(event: Event) {
        if let callUpdated = event as? CallUpdatedEvent {
            let index = calls.firstIndex { callData in
                callData.callCid == callUpdated.callCid
            }
            guard let index else {
                log.warning("Received an event for call that's not available")
                return
            }
            var call = calls[index]
            call.applyUpdates(from: callUpdated.call)
            calls[index] = call
        } else if event is WSDisconnected {
            self.socketDisconnected = true
        } else if event is WSConnected {
            if socketDisconnected {
                reWatchCalls()
            }
        }
    }
    
    private func reWatchCalls() {
        socketDisconnected = false
        guard callsQuery.watch else { return }
        // Clean up and re-watch the calls
        prev = nil
        next = nil
        Task {
            await state.update(loadedAllCalls: false)
            try await loadCalls(shouldRefresh: true)
        }
    }
    
    private func subscribeToWatchEvents() {
        watchTask = Task {
            for await event in streamVideo.watchEvents() {
                handle(event: event)
            }
        }
    }
    
    deinit {
        cleanUp()
    }
}

public struct CallData: Sendable {
    public let callCid: String
    public var members: [User]
    public let createdAt: Date
    public var backstage: Bool
    public var broadcasting: Bool
    public var endedAt: Date?
    public var recording: Bool
    public var startsAt: Date?
    public var updatedAt: Date
    
    mutating func applyUpdates(from callResponse: CallResponse) {
        self.backstage = callResponse.backstage
        self.broadcasting = callResponse.broadcasting
        self.endedAt = callResponse.endedAt
        self.recording = callResponse.recording
        self.startsAt = callResponse.startsAt
        self.updatedAt = callResponse.updatedAt
    }
}