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
    @EnvironmentObject var container: DependencyContainer

    var body: some View {
        ZStack {
            MapView(viewModel: container.viewModels.mapViewModel)
                .hide(isPresentedRunGuideDetailDescriptionView)
            VStack {
                RunGuideTabView(isPresentedRunGuideDetailDescriptionView: $isPresentedRunGuideDetailDescriptionView).padding(.top, 5)
                Spacer()
                BottomButtonView()
                    .environmentObject(container)
                    .padding(.bottom, 30)
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
