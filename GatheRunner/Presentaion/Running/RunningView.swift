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
                    isToggled: $isJustStartButtonSelected,
                    isOtherToggled: $isRunningGuideButtonSelected)
                .padding(15)
                MenuBtn(
                    title: "러닝 가이드",
                    isToggled: $isRunningGuideButtonSelected,
                    isOtherToggled: $isJustStartButtonSelected)
            }
            .frame(
                width: UIScreen.main.bounds.size.width,
                height: UIScreen.getHeightby(ratio: Size.menuBtnHstackFrameHeightRatio),
                alignment: .leading)
            BtnSelector(
                justStartButtonIsSelected: $isJustStartButtonSelected,
                runningGuideButtonIsSelected: $isRunningGuideButtonSelected)
            .frame(height: UIScreen.getHeightby(ratio: 0.72))
        }.ignoresSafeArea(edges: .top)
    }
    
    // MARK: Private
    
    @State private var isJustStartButtonSelected = true
    @State private var isRunningGuideButtonSelected = false
    
}

extension RunningView {
    private enum Size {
        static let menuBtnHstackFrameHeightRatio = 0.0355
    }
}
// MARK: - BtnSelector

struct BtnSelector: View {
    @Binding var justStartButtonIsSelected: Bool
    @Binding var runningGuideButtonIsSelected: Bool
    
    var body: some View {
        if justStartButtonIsSelected {
            JustStartView().transition(.move(edge: .leading))
        }
        
        if runningGuideButtonIsSelected {
            RunningGuideView().transition(.move(edge: .trailing))
        }
    }
}

// MARK: - MenuBtn

struct MenuBtn: View {
    var title: String
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
        .font(.system(size: CGFloat(Size.fontSize)))
    }
}

extension MenuBtn {
    private enum Size {
        static let fontSize = 14
    }
}

// MARK: - RunningView_Previews

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
