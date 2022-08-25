//
//  TabBarButton.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/07/21.
//

import SwiftUI

// MARK: - TabBarButton

struct TabBarButton: ButtonStyle {
    @EnvironmentObject var selectedTab: SelectedTab
    let tabIndex: Int

    func makeBody(configuration: Configuration) -> some View {
        Button {
            selectedTab.index = tabIndex
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
