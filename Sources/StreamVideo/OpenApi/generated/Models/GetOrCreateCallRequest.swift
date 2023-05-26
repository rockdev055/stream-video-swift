//
// GetOrCreateCallRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif





internal struct GetOrCreateCallRequest: Codable, JSONEncodable, Hashable {

    static let membersLimitRule = NumericRule<Int>(minimum: nil, exclusiveMinimum: false, maximum: 100, exclusiveMaximum: false, multipleOf: nil)
    internal var data: CallRequest?
    internal var membersLimit: Int?
    /** if provided it sends a notification event to the members for this call */
    internal var notify: Bool?
    /** if provided it sends a ring event to the members for this call */
    internal var ring: Bool?

    internal init(data: CallRequest? = nil, membersLimit: Int? = nil, notify: Bool? = nil, ring: Bool? = nil) {
        self.data = data
        self.membersLimit = membersLimit
        self.notify = notify
        self.ring = ring
    }

    internal enum CodingKeys: String, CodingKey, CaseIterable {
        case data
        case membersLimit = "members_limit"
        case notify
        case ring
    }

    // Encodable protocol methods

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(data, forKey: .data)
        try container.encodeIfPresent(membersLimit, forKey: .membersLimit)
        try container.encodeIfPresent(notify, forKey: .notify)
        try container.encodeIfPresent(ring, forKey: .ring)
    }
}

