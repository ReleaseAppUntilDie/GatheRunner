//
//  EmptyModifier.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/07/27.
//

import SwiftUI

// MARK: - EmptyModifier

struct EmptyModifier: ViewModifier {

    // MARK: Internal

    enum LogicalOperator {
        case and, or, none
    }

    let logicalOperator: LogicalOperator
    let conditions: [Bool]

    func body(content: Content) -> some View {
        if !checkedCondition {
            EmptyView()
        } else {
            content
        }
    }

    // MARK: Private

    private var checkedLogicalOperator: Bool? {
        switch logicalOperator {
        case .and: return false
        case .or: return true
        default: return nil
        }
    }

    private var checkedCondition: Bool {
        guard let result = checkedLogicalOperator else {
            return conditions[0]
        }

        for condition in conditions {
            if condition == result {
                return result
            }
        }
        return !result
    }
}

extension View {

    // MARK: - 사용 예시: .isEmpty(logicalOperator: .or, [type == .activity, type == .club])

    func isEmpty(logicalOperator: EmptyModifier.LogicalOperator, _ conditions: [Bool]) -> some View {
        modifier(EmptyModifier(logicalOperator: logicalOperator, conditions: conditions))
    }
}
