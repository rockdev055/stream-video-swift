---
title: Video View
---

Each participant in the video call has their own video view (card), that you can either customize or completely swap it with your own implementation.

If you are not using our SwiftUI SDK and the `ViewFactory` for customizations, you can still re-use our low-level components to build your own video views from scratch.

The important part here is to use the `track` from the `CallParticipant` class, for each of the participants. In order to save resources (both bandwidth and memory), you should hide the track when the user is not visible on the screen, and show it again when they become visible. This is already implemented in our SDK view layouts.

### RTCMTLVideoView

If you want to use WebRTC's view for displaying tracks, then you should use the `RTCMTLVideoView` view directly. In our SDK, we provide a subclass of this view, called `VideoRenderer`, which also provides access to the track.

### VideoRendererView

If you are using SwiftUI, you can use our `UIViewRepresentable` called `VideoRendererView`, since it simplifies the SwiftUI integration.

For example, here's how to use this view:

```swift
VideoRendererView(
    id: id,
    size: availableSize,
    contentMode: contentMode
) { view in
	view.handleViewRendering(participant) { size, participant in
		// handle track size update
	}
}
```

The `handleViewRendering` method is an extension method from the `VideoRenderer`, that adds the track to the view (if needed), and reports any track size changes to the caller:

```swift
extension VideoRenderer {
    
    func handleViewRendering(
        for participant: CallParticipant,
        onTrackSizeUpdate: @escaping (CGSize, CallParticipant) -> ()
    ) {
        if let track = participant.track {
            log.debug("adding track to a view \(self)")
            self.add(track: track)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                let prev = participant.trackSize
                let scale = UIScreen.main.scale
                let newSize = CGSize(
                    width: self.bounds.size.width * scale,
                    height: self.bounds.size.height * scale
                )
                if prev != newSize {
                    onTrackSizeUpdate(newSize, participant)
                }
            }
        }
    }
    
}
```

### Additional participant info

Apart from the video track, we show additional information in the video view, such as the name, network quality, audio / video state etc.

If you are using our SwiftUI SDK, this is controlled by the `VideoCallParticipantModifier`, which can be customized by implementing the `makeVideoCallParticipantModifier`.

For reference, here's the default `VideoCallParticipantModifier` implementation, that you can use for inspiration while implementing your own modifiers:

```swift
public struct VideoCallParticipantModifier: ViewModifier {
            
    @State var popoverShown = false
    
    var participant: CallParticipant
    @Binding var pinnedParticipant: CallParticipant?
    var participantCount: Int
    var availableSize: CGSize
    var ratio: CGFloat
    
    public init(
        participant: CallParticipant,
        pinnedParticipant: Binding<CallParticipant?>,
        participantCount: Int,
        availableSize: CGSize,
        ratio: CGFloat
    ) {
        self.participant = participant
        _pinnedParticipant = pinnedParticipant
        self.participantCount = participantCount
        self.availableSize = availableSize
        self.ratio = ratio
    }
    
    public func body(content: Content) -> some View {
        content
            .adjustVideoFrame(to: availableSize.width, ratio: ratio)
            .overlay(
                ZStack {
                    BottomView(content: {
                        HStack {
                            ParticipantInfoView(
                                participant: participant,
                                isPinned: participant.id == pinnedParticipant?.id
                            )
                            Spacer()
                            ConnectionQualityIndicator(
                                connectionQuality: participant.connectionQuality
                            )
                        }
                        .padding(.bottom, 2)
                    })
                        .padding()
                    
                    if participant.isSpeaking && participantCount > 1 {
                        Rectangle()
                            .strokeBorder(Color.blue.opacity(0.7), lineWidth: 2)
                    }
                    
                    if popoverShown {
                        Button {
                            if participant.id == pinnedParticipant?.id {
                                self.pinnedParticipant = nil
                            } else {
                                self.pinnedParticipant = participant
                            }
                            popoverShown = false
                        } label: {
                            Text(participant.id == pinnedParticipant?.id ? L10n.Call.Current.unpinUser : L10n.Call.Current.pinUser)
                                .padding(.horizontal)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .modifier(ShadowViewModifier())
                    }
                }
            )
            .onTapGesture(count: 2, perform: {
                popoverShown = true
            })
            .onTapGesture(count: 1) {
                if popoverShown {
                    popoverShown = false
                }
            }
    }
}
```

By default, this modifier is applied to the video call participant view:

```swift
ForEach(participants) { participant in
    viewFactory.makeVideoParticipantView(
        participant: participant,
        id: participant.id,
        availableSize: availableSize,
        contentMode: .scaleAspectFill,
        onViewUpdate: onViewUpdate
    )
    .modifier(
    	viewFactory.makeVideoCallParticipantModifier(
            participant: participant,
            participantCount: participants.count,
            pinnedParticipant: $pinnedParticipant,
            availableSize: availableSize,
            ratio: ratio
        )
    )
}
```

Note that the container above is ommited, since you can use a `LazyVGrid`, `LazyVStack`, `LazyHStack` or other container component, based on your UI requirements.