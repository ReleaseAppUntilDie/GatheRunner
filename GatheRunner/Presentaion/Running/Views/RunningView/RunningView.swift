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
                menuBtn("바로 시작", $isJustStartButtonSelected, $isRunningGuideButtonSelected).padding(15)
                menuBtn("러닝 가이드", $isRunningGuideButtonSelected, $isJustStartButtonSelected)
            }
            .frame(
                width: UIScreen.main.bounds.size.width,
                height: UIScreen.getHeightby(ratio: Size.menuBtnHstackFrameHeightRatio),
                alignment: .leading)
            btnSelector
                .frame(height: UIScreen.getHeightby(ratio: 0.72))
        }.ignoresSafeArea(edges: .top)
    }

    // MARK: Private

    @State private var isJustStartButtonSelected = true
    @State private var isRunningGuideButtonSelected = false
}

extension RunningView {
    @ViewBuilder
    var btnSelector: some View {
        if isJustStartButtonSelected {
            JustStartView().transition(.move(edge: .leading))
        }
        if isRunningGuideButtonSelected {
            RunGuideView().transition(.move(edge: .trailing))
        }
    }

    func menuBtn(_ title: String, _ isToggled: Binding<Bool>, _ isOtherToggled: Binding<Bool>) -> some View {
        Button(title) {
            withAnimation {
                if !isToggled.wrappedValue {
                    isToggled.wrappedValue.toggle()
                    isOtherToggled.wrappedValue.toggle()
                }
            }
        }
        .foregroundColor(isToggled.wrappedValue ? Color.black : Color.gray)
        .font(.system(size: CGFloat(Size.menuBtnFontSize)))
    }
}

extension RunningView {
    private enum Size {
        static let menuBtnHstackFrameHeightRatio = 0.0355
        static let menuBtnFontSize = 14
    }
}

// MARK: - RunningView_Previews

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
