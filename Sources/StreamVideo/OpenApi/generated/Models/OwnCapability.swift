//
// OwnCapability.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** All possibility of string to use */
internal enum OwnCapability: String, Codable, CaseIterable {
    case blockUsers = "block-users"
    case createCall = "create-call"
    case createReaction = "create-reaction"
    case endCall = "end-call"
    case joinBackstage = "join-backstage"
    case joinCall = "join-call"
    case joinEndedCall = "join-ended-call"
    case muteUsers = "mute-users"
    case readCall = "read-call"
    case removeCallMember = "remove-call-member"
    case screenshare = "screenshare"
    case sendAudio = "send-audio"
    case sendVideo = "send-video"
    case startBroadcastCall = "start-broadcast-call"
    case startRecordCall = "start-record-call"
    case startTranscriptionCall = "start-transcription-call"
    case stopBroadcastCall = "stop-broadcast-call"
    case stopRecordCall = "stop-record-call"
    case stopTranscriptionCall = "stop-transcription-call"
    case updateCall = "update-call"
    case updateCallMember = "update-call-member"
    case updateCallPermissions = "update-call-permissions"
    case updateCallSettings = "update-call-settings"
    case unknown = "_unknown"

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let decodedValue = try? container.decode(String.self),
            let value = OwnCapability(rawValue: decodedValue) {
            self = value
        } else {
            self = .unknown
        }
    }
}
