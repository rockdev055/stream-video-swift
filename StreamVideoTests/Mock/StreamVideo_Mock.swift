//
// Copyright © 2023 Stream.io Inc. All rights reserved.
//

@testable import StreamVideo

extension StreamVideo {
    static var apiKey = "key1"
    static var mockUser = UserFactory.get(1).first!
    
    static var mockToken = try! UserToken(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdHJlYW0tdmlkZW8tZ29AdjAuMS4wIiwic3ViIjoidXNlci90ZXN0dXNlciIsImlhdCI6MTY2NjY5ODczMSwidXNlcl9pZCI6InRlc3R1c2VyIn0.h4lnaF6OFYaNPjeK8uFkKirR5kHtj1vAKuipq3A5nM0")
    
    static func mock(httpClient: HTTPClient) -> StreamVideo {
        let streamVideo = StreamVideo(
            apiKey: apiKey,
            user: mockUser,
            token: mockToken,
            tokenProvider: { result in
                result(.success(mockToken))
            },
            pushNotificationsConfig: .default,
            environment: mockEnvironment(httpClient)
        )
        return streamVideo
    }
    
    static func mockEnvironment(_ httpClient: HTTPClient) -> Environment {
        return Environment(httpClientBuilder: { _ in
            httpClient
        }, callControllerBuilder: { callCoordinatorController, user, callId, callType, apiKey, videoConfig, eventsMiddleware in
            CallController_Mock(
                callCoordinatorController: callCoordinatorController,
                user: user,
                callId: callId,
                callType: callType,
                apiKey: apiKey,
                videoConfig: videoConfig,
                allEventsMiddleware: eventsMiddleware
            )
        }, callCoordinatorControllerBuilder: { httpClient, user, apiKey, hostname, token, videoConfig in
            CallCoordinatorController_Mock(
                httpClient: httpClient,
                user: user,
                coordinatorInfo: CoordinatorInfo(
                    apiKey: apiKey,
                    hostname: hostname,
                    token: token
                ),
                videoConfig: videoConfig
            )
        })
    }
    
}
