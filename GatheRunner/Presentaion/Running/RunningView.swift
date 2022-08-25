//
//  RunningView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

// MARK: - RunningView

struct RunningView: View {
    @State private var justStartButtonIsSelected = true
    @State private var runningGuideButtonIsSelected = false
    @State var selected = 0

    var body: some View {
        VStack(alignment: .center) {
            Text("Header View")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.1421)
            HStack {
                commonBtn(
                    title: "바로 시작",
                    fontSize: 14,
                    isToggled: $justStartButtonIsSelected,
                    isOtherToggled: $runningGuideButtonIsSelected)
                    .padding(15)
                commonBtn(
                    title: "러닝 가이드",
                    fontSize: 14,
                    isToggled: $runningGuideButtonIsSelected,
                    isOtherToggled: $justStartButtonIsSelected)
            }
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.0355, alignment: .leading)
            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)

            if justStartButtonIsSelected {
                JustStartView(selected: $selected)
                    .transition(.move(edge: .leading))
            }

            if runningGuideButtonIsSelected {
                RunningGuideView()
                    .transition(.move(edge: .trailing))
            }
        }.ignoresSafeArea(edges: .top)
    }
}

// MARK: - commonBtn

struct commonBtn: View {
    var title: String
    var fontSize: Int
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
        RunningView(selected: 0)
    }
}
