//
//  MainTabComponents.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/19.
//
import SwiftUI

enum MainTabComponents: String, CaseIterable {
    case run = "러닝"
    case activity = "활동"
    
    // MARK: Internal
    
    var tag: Int {
        switch self {
        case .run: return 1
        case .activity: return 2
        }
    }
}
