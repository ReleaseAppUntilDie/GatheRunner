//
//  SelectedTab.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/07/21.
//

import SwiftUI

class SelectedTab: ObservableObject {
    static var shared = SelectedTab()

    @Published var index = TabItem.MainComponent.home.tag
}
