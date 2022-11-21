//
//  TabBarButton.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/07/21.
//

import SwiftUI

// MARK: - TabBarButton

struct TabBarButton: ButtonStyle {
    let tabIndex: Int

    func makeBody(configuration: Configuration) -> some View {
        Button {
            SelectedTab.shared.mainIndex = tabIndex
        } label: {
            configuration.label
        }
    }
}

extension TabBarButton {
    init(_ tabIndex: Int) {
        self.init(tabIndex: tabIndex)
    }
}
