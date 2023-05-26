//
// NotificationSettingsRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif





internal struct NotificationSettingsRequest: Codable, JSONEncodable, Hashable {

    internal var callLiveStarted: EventNotificationSettingsRequest?
    internal var callNotification: EventNotificationSettingsRequest?
    internal var callRing: EventNotificationSettingsRequest?
    internal var enabled: Bool?
    internal var sessionStarted: EventNotificationSettingsRequest?

    internal init(callLiveStarted: EventNotificationSettingsRequest? = nil, callNotification: EventNotificationSettingsRequest? = nil, callRing: EventNotificationSettingsRequest? = nil, enabled: Bool? = nil, sessionStarted: EventNotificationSettingsRequest? = nil) {
        self.callLiveStarted = callLiveStarted
        self.callNotification = callNotification
        self.callRing = callRing
        self.enabled = enabled
        self.sessionStarted = sessionStarted
    }

    internal enum CodingKeys: String, CodingKey, CaseIterable {
        case callLiveStarted = "call_live_started"
        case callNotification = "call_notification"
        case callRing = "call_ring"
        case enabled
        case sessionStarted = "session_started"
    }

    // Encodable protocol methods

    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(callLiveStarted, forKey: .callLiveStarted)
        try container.encodeIfPresent(callNotification, forKey: .callNotification)
        try container.encodeIfPresent(callRing, forKey: .callRing)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(sessionStarted, forKey: .sessionStarted)
    }
}

