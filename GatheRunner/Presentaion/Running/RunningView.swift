//
//  RunningView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

struct RunningView: View {
    @State private var justStartButtonIsSelected: Bool = true
    @State private var runningGuideButtonIsSelected: Bool = false
    @EnvironmentObject var goalButton: GoalSettingViewModel
    @State var selected: Int = 0
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("Header View")
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.1421)
//                    .zIndex(2)
                HStack {
                    commonBtn(title: "바로 시작", fontSize: 14, isToggled: $justStartButtonIsSelected, isOtherToggled: $runningGuideButtonIsSelected)
                        .padding(4)
                    commonBtn(title: "러닝 가이드", fontSize: 14, isToggled: $runningGuideButtonIsSelected, isOtherToggled: $justStartButtonIsSelected)
                }
                .zIndex(1)
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.0355, alignment: .leading)
                if justStartButtonIsSelected {
                    JustStartView(selected: $selected)
                        .transition(.move(edge: .leading))
                }
                if runningGuideButtonIsSelected {
                    RunningGuideView()
                        .transition(.move(edge: .trailing))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea(edges: .top)
        }.overlay {
            Color.black.opacity(goalButton.isButtonSelected ? 0.4 : 0)
                .ignoresSafeArea()
        }
        .onTapGesture {
            withAnimation {
                goalButton.isButtonSelected = false
            }
        }
    }
}

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
        // 버튼이 너무 크면 UX 저하되기 때문에 고정 크기 사용
        .frame(width: 100, height: 10)
        .foregroundColor(isToggled ? Color.black : Color.gray)
        .font(.system(size: CGFloat(fontSize)))
    }
}


struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView(selected: 0)
            .environmentObject(GoalSettingViewModel())
    }
}
