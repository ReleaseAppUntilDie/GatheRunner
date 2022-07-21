//
//  GoalSettingViewModel.swift
//  GatheRunner
//
//  Created by cho on 2022/07/19.
//

import SwiftUI

class GoalSettingViewModel: ObservableObject {
    @Published var isButtonSelected: Bool = false
    
    private var goalSetting = [
        GoalSetting(title: "거리", tag: 0),
        GoalSetting(title: "시간", tag: 1),
        GoalSetting(title: "스피드", tag: 2)
    ]
    
    var getGoalSettingArrs: [GoalSetting] {
        return goalSetting
    }
}
