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
            switch fetchStatus {
            case .fetching: ActivityIndicatorView()
            case .failure:
                if let errorOption = errorOption {
                    ErrorView(errorMessage: errorOption.errorMessage, retryAction: errorOption.retryAction)
                } else {
                    content
                }
                
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
