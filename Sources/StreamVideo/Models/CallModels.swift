//
// Copyright © 2023 Stream.io Inc. All rights reserved.
//

import AVFoundation
import SwiftUI

/// Represents a participant event during a call.
public struct ParticipantEvent: Sendable {
    public let id: String
    public let action: ParticipantAction
    public let user: String
    public let imageURL: URL?
}

/// Represents a participant action (joining / leaving a call).
public enum ParticipantAction: Sendable {
    case join
    case leave
    
    public var display: String {
        switch self {
        case .leave:
            return "left"
        case .join:
            return "joined"
        }
    }
}

public enum RecordingState {
    case noRecording
    case requested
    case recording
}
