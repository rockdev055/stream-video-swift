//
// Copyright © 2023 Stream.io Inc. All rights reserved.
//

import SwiftUI

public struct Toast: Equatable {
    /// The style of the toast.
    public var style: ToastStyle
    /// The message displayed in the toast.
    public var message: String
    /// The placement of the toast.
    /// The default placement is `.top`.
    public var placement: ToastPlacement = .top
    /// The duration of the toast.
    public var duration: Double = 2.5
}

public enum ToastPlacement {
    /// The toast is displayed at the top.
    case top
    /// The toast is displayed at the bottom.
    case bottom
}

public enum ToastStyle {
    /// Displays error messages.
    case error
    /// Displays warning messages.
    case warning
    /// Displays success messages.
    case success
    /// Displays info messages.
    case info
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "exclamationmark.circle.fill"
        }
    }
}