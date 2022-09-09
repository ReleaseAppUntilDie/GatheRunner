//
//  EmptyStateViewModifier.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/07/27.
//

import SwiftUI

// MARK: - LogicalOperator (Constant 경로로 이동 예정)

enum LogicalOperator {
    case and, or
}

// MARK: - MultipleEmptyStateViewModifier

struct MultipleEmptyStateViewModifier<EmptyContent>: ViewModifier where EmptyContent: View {

    // MARK: Internal

    let logicalOperator: LogicalOperator
    let conditions: [Bool]
    let emptyContent: () -> EmptyContent

    func body(content: Content) -> some View {
        if !checkedCondition {
            emptyContent()
        } else {
            content
        }
    }

    // MARK: Private

    private var checkedLogicalOperator: Bool {
        switch logicalOperator {
        case .and: return false
        case .or: return true
        }
    }

    private var checkedCondition: Bool {
        for condition in conditions {
            if condition == checkedLogicalOperator {
                return checkedLogicalOperator
            }
        }
        return !checkedLogicalOperator
    }
}

// MARK: - SingleEmptyStateViewModifier

struct SingleEmptyStateViewModifier<EmptyContent>: ViewModifier where EmptyContent: View {
    var isEmpty: Bool
    let emptyContent: () -> EmptyContent

    func body(content: Content) -> some View {
        if isEmpty {
            emptyContent()
        }
        else {
            content
        }
    }
}

extension View {

    // MARK: - 사용 예시: .isEmpty(logicalOperator: .or, [type == .activity,type == .club]) { EmptyView() }

    func isEmpty<EmptyContent>(
        logicalOperator: LogicalOperator,
        _ conditions: [Bool],
        emptyContent: @escaping () -> EmptyContent)
        -> some View where EmptyContent: View
    {
        modifier(MultipleEmptyStateViewModifier(
            logicalOperator: logicalOperator,
            conditions: conditions,
            emptyContent: emptyContent))
    }

    func isEmpty<EmptyContent>(_ isEmpty: Bool, emptyContent: @escaping () -> EmptyContent) -> some View
        where EmptyContent: View
    {
        modifier(SingleEmptyStateViewModifier(isEmpty: isEmpty, emptyContent: emptyContent))
    }
}
