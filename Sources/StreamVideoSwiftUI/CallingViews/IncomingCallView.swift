//
// Copyright © 2023 Stream.io Inc. All rights reserved.
//

import NukeUI
import StreamVideo
import SwiftUI

@available(iOS 14.0, *)
public struct IncomingCallView: View {
    
    @Injected(\.streamVideo) var streamVideo
    @Injected(\.fonts) var fonts
    @Injected(\.colors) var colors
    @Injected(\.images) var images
    @Injected(\.utils) var utils
    
    @StateObject var viewModel: IncomingViewModel
            
    var onCallAccepted: (String) -> Void
    var onCallRejected: (String) -> Void
    
    public init(
        callInfo: IncomingCall,
        onCallAccepted: @escaping (String) -> Void,
        onCallRejected: @escaping (String) -> Void
    ) {
        _viewModel = StateObject(
            wrappedValue: IncomingViewModel(callInfo: callInfo)
        )
        self.onCallAccepted = onCallAccepted
        self.onCallRejected = onCallRejected
    }
    
    public var body: some View {
        IncomingCallViewContent(
            callParticipants: viewModel.callParticipants,
            callInfo: viewModel.callInfo,
            onCallAccepted: onCallAccepted,
            onCallRejected: onCallRejected
        )
    }
}

struct IncomingCallViewContent: View {
    
    @Injected(\.streamVideo) var streamVideo
    @Injected(\.fonts) var fonts
    @Injected(\.colors) var colors
    @Injected(\.images) var images
    @Injected(\.utils) var utils
    
    var callParticipants: [CallParticipant]
    var callInfo: IncomingCall
    var onCallAccepted: (String) -> Void
    var onCallRejected: (String) -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            if callParticipants.count > 1 {
                CallingGroupView(
                    participants: callParticipants.map { $0.toUser() }
                )
            } else {
                AnimatingParticipantView(
                    participant: callParticipants.first?.toUser(),
                    caller: callInfo.callerId
                )
            }
            
            CallingParticipantsView(
                participants: callParticipants.map { $0.toUser() },
                caller: callInfo.callerId
            )
            .padding()
            
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(L10n.Call.Incoming.title)
                    .applyCallingStyle()
                CallingIndicator()
            }
            
            Spacer()
            
            HStack {
                Spacing()
                
                Button {
                    onCallRejected(callInfo.id)
                } label: {
                    images.hangup
                        .applyCallButtonStyle(
                            color: Color.red,
                            backgroundType: .circle,
                            size: 80
                        )
                }
                .padding(.all, 8)
                
                Spacing(size: 3)
                
                Button {
                    onCallAccepted(callInfo.id)
                } label: {
                    images.acceptCall
                        .applyCallButtonStyle(
                            color: Color.green,
                            backgroundType: .circle,
                            size: 80
                        )
                }
                .padding(.all, 8)
                
                Spacing()
            }
            .padding()
        }
        .background(
            FallbackBackground()
        )
        .onAppear {
            utils.callSoundsPlayer.playIncomingCallSound()
        }
        .onDisappear {
            utils.callSoundsPlayer.stopOngoingSound()
        }
    }
}
