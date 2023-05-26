//
// VideoEvent.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** The discriminator object for all websocket events, you should use this to map event payloads to their own type */



internal class VideoEventMapping: Decodable {
    let type: String
}

internal enum VideoEvent: Codable, JSONEncodable, Hashable {
    case typeBlockedUserEvent(BlockedUserEvent)
    case typeCallAcceptedEvent(CallAcceptedEvent)
    case typeCallBroadcastingStartedEvent(CallBroadcastingStartedEvent)
    case typeCallBroadcastingStoppedEvent(CallBroadcastingStoppedEvent)
    case typeCallCreatedEvent(CallCreatedEvent)
    case typeCallEndedEvent(CallEndedEvent)
    case typeCallLiveStartedEvent(CallLiveStartedEvent)
    case typeCallMemberAddedEvent(CallMemberAddedEvent)
    case typeCallMemberRemovedEvent(CallMemberRemovedEvent)
    case typeCallMemberUpdatedEvent(CallMemberUpdatedEvent)
    case typeCallMemberUpdatedPermissionEvent(CallMemberUpdatedPermissionEvent)
    case typeCallNotificationEvent(CallNotificationEvent)
    case typeCallReactionEvent(CallReactionEvent)
    case typeCallRecordingStartedEvent(CallRecordingStartedEvent)
    case typeCallRecordingStoppedEvent(CallRecordingStoppedEvent)
    case typeCallRejectedEvent(CallRejectedEvent)
    case typeCallRingEvent(CallRingEvent)
    case typeCallSessionEndedEvent(CallSessionEndedEvent)
    case typeCallSessionParticipantJoinedEvent(CallSessionParticipantJoinedEvent)
    case typeCallSessionParticipantLeftEvent(CallSessionParticipantLeftEvent)
    case typeCallSessionStartedEvent(CallSessionStartedEvent)
    case typeCallUpdatedEvent(CallUpdatedEvent)
    case typeConnectedEvent(ConnectedEvent)
    case typeCustomVideoEvent(CustomVideoEvent)
    case typeHealthCheckEvent(HealthCheckEvent)
    case typePermissionRequestEvent(PermissionRequestEvent)
    case typeUnblockedUserEvent(UnblockedUserEvent)
    case typeUpdatedCallPermissionsEvent(UpdatedCallPermissionsEvent)

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeBlockedUserEvent(let value):
            try container.encode(value)
        case .typeCallAcceptedEvent(let value):
            try container.encode(value)
        case .typeCallBroadcastingStartedEvent(let value):
            try container.encode(value)
        case .typeCallBroadcastingStoppedEvent(let value):
            try container.encode(value)
        case .typeCallCreatedEvent(let value):
            try container.encode(value)
        case .typeCallEndedEvent(let value):
            try container.encode(value)
        case .typeCallLiveStartedEvent(let value):
            try container.encode(value)
        case .typeCallMemberAddedEvent(let value):
            try container.encode(value)
        case .typeCallMemberRemovedEvent(let value):
            try container.encode(value)
        case .typeCallMemberUpdatedEvent(let value):
            try container.encode(value)
        case .typeCallMemberUpdatedPermissionEvent(let value):
            try container.encode(value)
        case .typeCallNotificationEvent(let value):
            try container.encode(value)
        case .typeCallReactionEvent(let value):
            try container.encode(value)
        case .typeCallRecordingStartedEvent(let value):
            try container.encode(value)
        case .typeCallRecordingStoppedEvent(let value):
            try container.encode(value)
        case .typeCallRejectedEvent(let value):
            try container.encode(value)
        case .typeCallRingEvent(let value):
            try container.encode(value)
        case .typeCallSessionEndedEvent(let value):
            try container.encode(value)
        case .typeCallSessionParticipantJoinedEvent(let value):
            try container.encode(value)
        case .typeCallSessionParticipantLeftEvent(let value):
            try container.encode(value)
        case .typeCallSessionStartedEvent(let value):
            try container.encode(value)
        case .typeCallUpdatedEvent(let value):
            try container.encode(value)
        case .typeConnectedEvent(let value):
            try container.encode(value)
        case .typeCustomVideoEvent(let value):
            try container.encode(value)
        case .typeHealthCheckEvent(let value):
            try container.encode(value)
        case .typePermissionRequestEvent(let value):
            try container.encode(value)
        case .typeUnblockedUserEvent(let value):
            try container.encode(value)
        case .typeUpdatedCallPermissionsEvent(let value):
            try container.encode(value)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dto = try container.decode(VideoEventMapping.self)
        if dto.type == "call.accepted" {
            let value = try container.decode(CallAcceptedEvent.self)
            self = .typeCallAcceptedEvent(value)
        } else if dto.type == "call.blocked_user" {
            let value = try container.decode(BlockedUserEvent.self)
            self = .typeBlockedUserEvent(value)
        } else if dto.type == "call.broadcasting_started" {
            let value = try container.decode(CallBroadcastingStartedEvent.self)
            self = .typeCallBroadcastingStartedEvent(value)
        } else if dto.type == "call.broadcasting_stopped" {
            let value = try container.decode(CallBroadcastingStoppedEvent.self)
            self = .typeCallBroadcastingStoppedEvent(value)
        } else if dto.type == "call.created" {
            let value = try container.decode(CallCreatedEvent.self)
            self = .typeCallCreatedEvent(value)
        } else if dto.type == "call.ended" {
            let value = try container.decode(CallEndedEvent.self)
            self = .typeCallEndedEvent(value)
        } else if dto.type == "call.live_started" {
            let value = try container.decode(CallLiveStartedEvent.self)
            self = .typeCallLiveStartedEvent(value)
        } else if dto.type == "call.member_added" {
            let value = try container.decode(CallMemberAddedEvent.self)
            self = .typeCallMemberAddedEvent(value)
        } else if dto.type == "call.member_removed" {
            let value = try container.decode(CallMemberRemovedEvent.self)
            self = .typeCallMemberRemovedEvent(value)
        } else if dto.type == "call.member_updated" {
            let value = try container.decode(CallMemberUpdatedEvent.self)
            self = .typeCallMemberUpdatedEvent(value)
        } else if dto.type == "call.member_updated_permission" {
            let value = try container.decode(CallMemberUpdatedPermissionEvent.self)
            self = .typeCallMemberUpdatedPermissionEvent(value)
        } else if dto.type == "call.notification" {
            let value = try container.decode(CallNotificationEvent.self)
            self = .typeCallNotificationEvent(value)
        } else if dto.type == "call.permission_request" {
            let value = try container.decode(PermissionRequestEvent.self)
            self = .typePermissionRequestEvent(value)
        } else if dto.type == "call.permissions_updated" {
            let value = try container.decode(UpdatedCallPermissionsEvent.self)
            self = .typeUpdatedCallPermissionsEvent(value)
        } else if dto.type == "call.reaction_new" {
            let value = try container.decode(CallReactionEvent.self)
            self = .typeCallReactionEvent(value)
        } else if dto.type == "call.recording_started" {
            let value = try container.decode(CallRecordingStartedEvent.self)
            self = .typeCallRecordingStartedEvent(value)
        } else if dto.type == "call.recording_stopped" {
            let value = try container.decode(CallRecordingStoppedEvent.self)
            self = .typeCallRecordingStoppedEvent(value)
        } else if dto.type == "call.rejected" {
            let value = try container.decode(CallRejectedEvent.self)
            self = .typeCallRejectedEvent(value)
        } else if dto.type == "call.ring" {
            let value = try container.decode(CallRingEvent.self)
            self = .typeCallRingEvent(value)
        } else if dto.type == "call.session_ended" {
            let value = try container.decode(CallSessionEndedEvent.self)
            self = .typeCallSessionEndedEvent(value)
        } else if dto.type == "call.session_participant_joined" {
            let value = try container.decode(CallSessionParticipantJoinedEvent.self)
            self = .typeCallSessionParticipantJoinedEvent(value)
        } else if dto.type == "call.session_participant_left" {
            let value = try container.decode(CallSessionParticipantLeftEvent.self)
            self = .typeCallSessionParticipantLeftEvent(value)
        } else if dto.type == "call.session_started" {
            let value = try container.decode(CallSessionStartedEvent.self)
            self = .typeCallSessionStartedEvent(value)
        } else if dto.type == "call.unblocked_user" {
            let value = try container.decode(UnblockedUserEvent.self)
            self = .typeUnblockedUserEvent(value)
        } else if dto.type == "call.updated" {
            let value = try container.decode(CallUpdatedEvent.self)
            self = .typeCallUpdatedEvent(value)
        } else if dto.type == "connection.ok" {
            let value = try container.decode(ConnectedEvent.self)
            self = .typeConnectedEvent(value)
        } else if dto.type == "custom" {
            let value = try container.decode(CustomVideoEvent.self)
            self = .typeCustomVideoEvent(value)
        } else if dto.type == "health.check" {
            let value = try container.decode(HealthCheckEvent.self)
            self = .typeHealthCheckEvent(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of VideoEvent"))
        }
    }

}

