//
//  LoadableView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/29.
//

import SwiftUI

typealias ErrorOption = (errorMessage: String, retryAction: () -> Void)

struct LoadableView: ViewModifier {
    @Binding var fetchStatus: FetchStatus
    
    var errorOption: ErrorOption?
    
    func body(content: Content) -> some View {
        Group {
            switch (fetchStatus, errorOption) {
            case (.fetching, _): ActivityIndicatorView()
            case (.failure, .some(let option)): ErrorView(errorMessage: option.errorMessage, retryAction: option.retryAction)
            default: content
            }
        }
    }
}

extension View {
    func didSetLoadable(by fetchStatus: Binding<FetchStatus>,
                        withError errorOption: ErrorOption? = nil) -> some View {
        modifier(LoadableView(fetchStatus: fetchStatus, errorOption: errorOption))
    }
}
