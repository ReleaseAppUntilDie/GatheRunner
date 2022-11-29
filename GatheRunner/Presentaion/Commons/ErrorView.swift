//
//  ErrorView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/29.
//

import SwiftUI

struct ErrorView: View {
    private enum Size {
        static let padding: CGFloat = 40
    }
    
    private enum Label {
        static let title = "에러 발생"
        static let retry = "재시도"
    }
    
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text(Label.title)
                .font(.title)
            
            Text(errorMessage)
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.bottom, Size.padding).padding()
            
            Button(action: retryAction, label: { Text(Label.retry).bold() } )
        }
    }
}
