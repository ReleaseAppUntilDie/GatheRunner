//
//  ButtonStyle.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/07/21.
//

import SwiftUI

struct TabBarButton: ViewModifier {
    @EnvironmentObject var selectedTab: SelectedTab
    let tabIndex: Int
    let iconName: String

    func body(content: Content) -> some View {
        content
            .overlay(
                Button(action: {
                    selectedTab.index = tabIndex
                }) {
                    HStack() {
                        Image(systemName: iconName)
                            .imageScale(.large)
                            .frame(minWidth: 50)
                    }
                }
            )
    }
}

extension View {
    func tabBarBtnStyle(tabIndex: Int, iconName: String) -> some View {
        self.modifier(TabBarButton(tabIndex: tabIndex, iconName: iconName))
    }
}
