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
            viewSelectorButton
                .frame(width: UIScreen.main.bounds.size.width,
                height: UIScreen.getHeightby(ratio: Size.viewSelectorButtonHstackFrameHeightRatio),
                alignment: .leading)
            viewSelector
                .frame(height: UIScreen.getHeightby(ratio: 0.72))
        }.ignoresSafeArea(edges: .top)
    }
    
    // MARK: Private
    
    @State private var selectedButton: ButtonName = .justStartButton
}

extension RunningView {
    @ViewBuilder
    var viewSelector: some View {
        if selectedButton == .justStartButton {
            JustStartView().transition(.move(edge: .leading))
        } else {
            RunGuideView().transition(.move(edge: .trailing))
        }
    }

    var viewSelectorButton: some View {
        HStack {
            Button("바로 시작") {
                withAnimation {
                    selectedButton = .justStartButton
                }
            }
            .foregroundColor(selectedButton == .justStartButton ? Color.black : Color.gray)
            .padding(15)
            Button("러닝 가이드") {
                withAnimation {
                    selectedButton = .runGuideButton
                }
            }.foregroundColor(selectedButton == .runGuideButton ? Color.black : Color.gray)
        }.font(.system(size: CGFloat(Size.viewSelectorButtonFontSize)))
    }
}

extension RunningView {
    private enum Size {
        static let viewSelectorButtonHstackFrameHeightRatio = 0.0355
        static let viewSelectorButtonFontSize = 14
    }
    
    enum ButtonName {
        case justStartButton
        case runGuideButton
    }
}

// MARK: - RunningView_Previews

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
