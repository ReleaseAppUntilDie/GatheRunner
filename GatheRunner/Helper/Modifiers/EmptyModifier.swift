//
//  EmptyModifier.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/07/27.
//

import SwiftUI

struct EmptyModifier: ViewModifier {
    enum conditionalState {
        case and, or, single
    }
    
    let state: conditionalState
    let conditions: [Bool]
    
    func body(content: Content) -> some View {
        if !checkedCondition() {
            EmptyView()
        } else {
            content
        }
    }
    
    func checkedCondition() -> Bool {
        switch self.state {
        case .and: return checkedMultipleConditions(compare: false)
        case .or: return checkedMultipleConditions(compare: true)
        case .single: return self.conditions[0]
            
        }
    }
    
    func checkedMultipleConditions(compare: Bool) -> Bool {
        var result = !compare
        for condition in self.conditions {
            if condition == compare {
                result = compare
                break
            }
        }
        return result
    }
}

extension View {
    
    //MARK: - 사용 예시: .isEmpty(state: .or, [type == .activity, type == .club])
    
    func isEmpty(state: EmptyModifier.conditionalState, _ conditions: [Bool]) -> some View {
        modifier(EmptyModifier(state: state, conditions: conditions))
    }
}
