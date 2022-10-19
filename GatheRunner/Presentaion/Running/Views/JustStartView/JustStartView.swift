//
//  JustStartView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

// MARK: - JustStartView

struct JustStartView: View {
    @State private var isPresentedRunGuideDetailDescriptionView = false

    var body: some View {
        ZStack {
            MapView().hide(isPresentedRunGuideDetailDescriptionView)
            VStack {
                RunGuideTabView(isPresentedRunGuideDetailDescriptionView: $isPresentedRunGuideDetailDescriptionView).padding(.top, 5)
                Spacer()
                BottomButtonsView().padding(.bottom, 30)
            }
        }
    }
}

// MARK: - JustStartView_Previews

struct JustStartView_Previews: PreviewProvider {
    static var previews: some View {
        JustStartView()
    }
}
