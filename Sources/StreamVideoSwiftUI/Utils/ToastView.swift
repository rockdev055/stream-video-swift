//
// Copyright © 2023 Stream.io Inc. All rights reserved.
//

import SwiftUI

/// View that displays different types of toasts.
public struct ToastView: View {
    var style: ToastStyle
    var message: String
    var onCancelTapped: (() -> Void)
    
    public init(
        style: ToastStyle,
        message: String,
        onCancelTapped: @escaping (() -> Void)
    ) {
        self.style = style
        self.message = message
        self.onCancelTapped = onCancelTapped
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundColor(style.themeColor)
            
            Text(message)
                .font(Font.caption)
                .foregroundColor(Color.primary)
            
            Spacer(minLength: 10)
            
            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(style.themeColor)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .modifier(ShadowViewModifier(borderColor: style.themeColor))
        .padding(.horizontal, 16)
    }
}

@available(iOS 14.0, *)
public struct ToastModifier: ViewModifier {
    
    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?
    
    public init(toast: Binding<Toast?>) {
        _toast = toast
    }
    
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    toastView()
                        .offset(y: toast?.placement == .bottom ? -16 : 16)
                }
                .animation(.spring(), value: toast)
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }
    
    @ViewBuilder func toastView() -> some View {
        if let toast = toast {
            VStack {
                if toast.placement == .bottom {
                    Spacer()
                }
                ToastView(
                    style: toast.style,
                    message: toast.message
                ) {
                    dismissToast()
                }
                if toast.placement == .top {
                    Spacer()
                }
            }
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

@available(iOS 14.0, *)
extension View {
    public func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
