//
// WSConnectedEvent.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** This event is sent when the WS connection is established and authenticated, this event contains the full user object as it is stored on the server */
internal struct WSConnectedEvent: Codable, JSONEncodable, Hashable {

    /** The connection_id for this client */
    internal var connectionId: String
    internal var createdAt: Date
    internal var me: OwnUserResponse
    /** The type of event: \"connection.ok\" in this case */
    internal var type: String

    internal init(connectionId: String, createdAt: Date, me: OwnUserResponse, type: String) {
        self.connectionId = connectionId
        self.createdAt = createdAt
        self.me = me
        self.type = type
    }

    internal enum CodingKeys: String, CodingKey, CaseIterable {
        case connectionId = "connection_id"
        case createdAt = "created_at"
        case me
        case type
    }

    // Encodable protocol methods

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(connectionId, forKey: .connectionId)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(me, forKey: .me)
        try container.encode(type, forKey: .type)
    }
}

