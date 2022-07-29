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
    @ObservedObject var goalButton = GoalSettingViewModel.shared
    @State var selected: Int = 0
    
    var body: some View {
        ZStack {
        VStack(alignment: .center) {
            Text("Header View")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.1421)
            HStack {
                commonBtn(title: "바로 시작", fontSize: 14, isToggled: $justStartButtonIsSelected, isOtherToggled: $runningGuideButtonIsSelected)
                    .padding(15)
                commonBtn(title: "러닝 가이드", fontSize: 14, isToggled: $runningGuideButtonIsSelected, isOtherToggled: $justStartButtonIsSelected)
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
        }.overlay {
            Color.black.opacity(goalButton.isButtonSelected ? 0.4 : 0)
        }
        .onTapGesture {
            withAnimation {
                goalButton.isButtonSelected = false
            }
        }.ignoresSafeArea(edges: .top)
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
        .foregroundColor(isToggled ? Color.black : Color.gray)
        .font(.system(size: CGFloat(fontSize)))
    }
}


struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView(selected: 0).environmentObject(GoalSettingViewModel())
    }
}
