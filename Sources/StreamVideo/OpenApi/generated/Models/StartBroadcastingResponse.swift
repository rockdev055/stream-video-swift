//
// StartBroadcastingResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif





internal struct StartBroadcastingResponse: Codable, JSONEncodable, Hashable {

    /** Duration of the request in human-readable format */
    internal var duration: String
    internal var playlistUrl: String

    internal init(duration: String, playlistUrl: String) {
        self.duration = duration
        self.playlistUrl = playlistUrl
    }

    internal enum CodingKeys: String, CodingKey, CaseIterable {
        case duration
        case playlistUrl = "playlist_url"
    }

    // Encodable protocol methods

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(duration, forKey: .duration)
        try container.encode(playlistUrl, forKey: .playlistUrl)
    }
}

