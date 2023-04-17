//
// CreateGuestResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif





internal struct CreateGuestResponse: Codable, JSONEncodable, Hashable {

    /** the access token to authenticate the user */
    internal var accessToken: String
    internal var duration: String
    internal var user: UserResponse

    internal init(accessToken: String, duration: String, user: UserResponse) {
        self.accessToken = accessToken
        self.duration = duration
        self.user = user
    }

    internal enum CodingKeys: String, CodingKey, CaseIterable {
        case accessToken = "access_token"
        case duration
        case user
    }

    // Encodable protocol methods

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accessToken, forKey: .accessToken)
        try container.encode(duration, forKey: .duration)
        try container.encode(user, forKey: .user)
    }
}
