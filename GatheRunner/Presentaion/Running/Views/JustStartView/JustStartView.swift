//
//  JustStartView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

// MARK: - JustStartView

struct JustStartView: View {
    @StateObject private var manager = LocationManager()
    @State private var isPresentedRunGuideDetailDescriptionView = false

    var body: some View {
        ZStack {
            MapView().hide(isPresentedRunGuideDetailDescriptionView)
            VStack {
                RunGuideTabView(isPresentedRunGuideDetailDescriptionView: $isPresentedRunGuideDetailDescriptionView)
                Spacer()
                BottomButtonsView()
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
