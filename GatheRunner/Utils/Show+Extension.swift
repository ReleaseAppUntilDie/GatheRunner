//
//  Show+Extension.swift
//  GatheRunner
//
//  Created by cho on 2022/10/11.
//

import SwiftUI

// MARK: - Show

struct Show: ViewModifier {
    let isVisible: Bool

    @ViewBuilder
    func body(content: Content) -> some View {
        if isVisible {
            content
        } else {
            content.hidden()
        }
    }
}

extension View {
    func show(isVisible: Bool) -> some View {
        ModifiedContent(content: self, modifier: Show(isVisible: isVisible))
    }
}
