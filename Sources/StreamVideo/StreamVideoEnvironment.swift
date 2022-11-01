//
// Copyright © 2022 Stream.io Inc. All rights reserved.
//

import Foundation

extension StreamVideo {
    struct Environment {
        var httpClientBuilder: (
            _ tokenProvider: @escaping TokenProvider
        ) -> HTTPClient = {
            URLSessionClient(
                urlSession: Self.makeURLSession(),
                tokenProvider: $0
            )
        }
        
        var callCoordinatorControllerBuilder: (
            _ httpClient: HTTPClient,
            _ user: UserInfo,
            _ apiKey: String,
            _ hostname: String,
            _ token: Token,
            _ videoConfig: VideoConfig
        ) -> CallCoordinatorController = {
            CallCoordinatorController(
                httpClient: $0,
                userInfo: $1,
                coordinatorInfo: CoordinatorInfo(
                    apiKey: $2,
                    hostname: $3,
                    token: $4.rawValue
                ),
                videoConfig: $5
            )
        }
        
        var latencyServiceBuilder: (
            _ httpClient: HTTPClient
        ) -> LatencyService = {
            LatencyService(httpClient: $0)
        }
        
        var connectionRecoveryHandlerBuilder: (
            _ webSocketClient: WebSocketClient,
            _ eventNotificationCenter: EventNotificationCenter
        ) -> ConnectionRecoveryHandler = {
            DefaultConnectionRecoveryHandler(
                webSocketClient: $0,
                eventNotificationCenter: $1,
                backgroundTaskScheduler: backgroundTaskSchedulerBuilder(),
                internetConnection: InternetConnection(monitor: InternetConnection.Monitor()),
                reconnectionStrategy: DefaultRetryStrategy(),
                reconnectionTimerType: DefaultTimer.self,
                keepConnectionAliveInBackground: true
            )
        }
        
        private static var backgroundTaskSchedulerBuilder: () -> BackgroundTaskScheduler? = {
            if Bundle.main.isAppExtension {
                // No background task scheduler exists for app extensions.
                return nil
            } else {
                #if os(iOS)
                return IOSBackgroundTaskScheduler()
                #else
                // No need for background schedulers on macOS, app continues running when inactive.
                return nil
                #endif
            }
        }
        
        internal static func makeURLSession() -> URLSession {
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            config.urlCache = nil
            let urlSession = URLSession(configuration: config)
            return urlSession
        }
    }
}