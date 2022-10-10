//
// Copyright © 2022 Stream.io Inc. All rights reserved.
//

import Foundation

/// Represents a call event.
public enum CallEvent {
    /// Incoming call.
    case incoming(IncomingCall)
    /// An outgoing call is accepted.
    case accepted(CallEventInfo)
    /// An outgoing call is rejected.
    case rejected(CallEventInfo)
    /// An outgoing call is canceled.
    case canceled(CallEventInfo)
}

enum CallEventAction {
    case accept
    case reject
    case cancel
}

struct IncomingCallEvent: Event {
    let proto: Stream_Video_CallCreated
    let createdBy: String
    let type: String
    let users: [Stream_Video_User]
}

/// Contains info about a call event.
public struct CallEventInfo: Event {
    let callId: String
    let senderId: String
    let action: CallEventAction
}
