//
// Copyright © 2023 Stream.io Inc. All rights reserved.
//

import Foundation
import SwiftUI
import StreamVideo
import StreamVideoSwiftUI

struct DemoQRCodeScannerButton: View {

    @Injected(\.appearance) var appearance

    @State private var isQRScannerPresented = false
    @ObservedObject var viewModel: CallViewModel
    private let completion: (String?) -> Void
    private let deeplinkAdapter: DeeplinkAdapter

    init(
        viewModel: CallViewModel,
        completion: @escaping (String?) -> Void
    ) {
        self.viewModel = viewModel
        self.completion = completion
        self.deeplinkAdapter = DeeplinkAdapter()
    }

    var body: some View {
#if !targetEnvironment(simulator) && !os(macOS)
        Button {
            isQRScannerPresented = true
        } label: {
            Image(systemName: "qrcode.viewfinder")
                .foregroundColor(.init(appearance.colors.textLowEmphasis))
        }
        .padding(.trailing)
        .halfSheetIfAvailable(isPresented: $isQRScannerPresented) {
            CodeScannerView(codeTypes: [.qr]) { result in
                switch result {
                case .success(let scanResult):
                    if let url = URL(string: scanResult.string), url.isWeb {
                        if deeplinkAdapter.canHandle(url: url) {
                            let callId = deeplinkAdapter.handle(url: url).deeplinkInfo.callId
                            completion(callId)
                        } else {
                            viewModel.toast = Toast(style: .error, message: "The recognised URL from the QR code isn't supported.")
                            completion(nil)
                        }
                    } else {
                        completion(scanResult.string)
                    }
                case .failure(let error):
                    log.error(error)
                    viewModel.toast = Toast(style: .error, message: "\(error)")
                    completion(nil)
                }
                isQRScannerPresented = false
            }
            .ignoresSafeArea()
        }
#else
    EmptyView()
#endif
    }
}

