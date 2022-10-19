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
                height: UIScreen.getHeightby(ratio: Size.viewSelectorButtonHeightRatio),
                alignment: .leading)
            viewSelector
                .frame(height: UIScreen.getHeightby(ratio: 0.72))
        }.ignoresSafeArea(edges: .top)
    }
    
    // MARK: Private
    
    @EnvironmentObject var recentSelectButton: SelectedButtonMemory
}

extension RunningView {
    @ViewBuilder
    var viewSelector: some View {
        if recentSelectButton.selectedButton == .justStartButton {
            JustStartView()
                .transition(.move(edge: .leading))
                .zIndex(-1)
        }
        if recentSelectButton.selectedButton == .runGuideButton {
            RunGuideView().transition(.move(edge: .trailing))
        }
    }

    var viewSelectorButton: some View {
        HStack {
            Button("바로 시작") {
                withAnimation {
                    recentSelectButton.selectedButton = .justStartButton
                }
            }
            .foregroundColor(recentSelectButton.selectedButton == .justStartButton ? Color.black : Color.gray)
            .padding(15)
            Button("러닝 가이드") {
                withAnimation {
                    recentSelectButton.selectedButton = .runGuideButton
                }
            }.foregroundColor(recentSelectButton.selectedButton == .runGuideButton ? Color.black : Color.gray)
        }.font(.system(size: CGFloat(Size.viewSelectorButtonFontSize)))
    }
}

extension RunningView {
    private enum Size {
        static let viewSelectorButtonHeightRatio = 0.0355
        static let viewSelectorButtonFontSize = 14
    }
}

// MARK: - RunningView_Previews

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
