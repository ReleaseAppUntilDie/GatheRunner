//
//  RunningView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

// MARK: - RunningView

struct RunningView: View {

    // MARK: Internal

    var body: some View {
        VStack(alignment: .center) {
            HeaderView(title: "러닝", type: .running, rightButtonAction: { })
            HStack {
                MenuBtn(
                    title: "바로 시작",
                    isToggled: $justStartButtonIsSelected,
                    isOtherToggled: $runningGuideButtonIsSelected)
                    .padding(15)
                MenuBtn(
                    title: "러닝 가이드",
                    isToggled: $runningGuideButtonIsSelected,
                    isOtherToggled: $justStartButtonIsSelected)
            }
            .frame(
                width: UIScreen.main.bounds.size.width,
                height: UIScreen.getHeightby(ratio: menuBtnHstackFrameHeightRatio),
                alignment: .leading)
            BtnSelector(
                justStartButtonIsSelected: $justStartButtonIsSelected,
                runningGuideButtonIsSelected: $runningGuideButtonIsSelected)
        }.ignoresSafeArea(edges: .top)
    }

    // MARK: Private

    @State private var justStartButtonIsSelected = true
    @State private var runningGuideButtonIsSelected = false
    private let menuBtnHstackFrameHeightRatio = 0.0355
}

// MARK: - BtnSelector

struct BtnSelector: View {
    @State var selectedRunGuideTabItem = 0
    @Binding var justStartButtonIsSelected: Bool
    @Binding var runningGuideButtonIsSelected: Bool

    var body: some View {
        if justStartButtonIsSelected {
            JustStartView(selectedRunGuideTabItem: $selectedRunGuideTabItem).transition(.move(edge: .leading))
        }

        if runningGuideButtonIsSelected {
            RunningGuideView()
                .transition(.move(edge: .trailing))
        }
    }
}

// MARK: - MenuBtn

struct MenuBtn: View {
    var title: String
    private let fontSize = 14
    @Binding var isToggled: Bool
    @Binding var isOtherToggled: Bool

    var body: some View {
        Button(title) {
            withAnimation {
                if !isToggled {
                    self.isToggled.toggle()
                    self.isOtherToggled.toggle()
                }
            }
        }
        .foregroundColor(isToggled ? Color.black : Color.gray)
        .font(.system(size: CGFloat(fontSize)))
    }
}

// MARK: - RunningView_Previews

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
