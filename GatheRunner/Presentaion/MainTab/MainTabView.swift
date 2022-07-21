//
//  ContentView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 1
    @EnvironmentObject var goalButton: GoalSettingViewModel
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ForEach(tabItems) { $0.body }
            }
            .accentColor(.black)
            
            VStack {
                Spacer()
                if goalButton.isButtonSelected {
                    BottomSheet()
                        .frame(width: UIScreen.main.bounds.width, height: 220)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

struct BottomSheet: View {
    private var getGoalSettingArrs = GoalSettingViewModel().getGoalSettingArrs
    @EnvironmentObject var goalButton: GoalSettingViewModel
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(getGoalSettingArrs.indices) { index in
                Text(getGoalSettingArrs[index].title)
                if getGoalSettingArrs.count - 1 > index {
                    Divider()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .mask(RoundedTopCorner(radius: 30))
        .ignoresSafeArea()
    }
}

extension MainTabView {
    private var tabItems: [TabItem] {
        [TabItem(.home), TabItem(.run), TabItem(.club), TabItem(.activity)]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(GoalSettingViewModel())
    }
}
