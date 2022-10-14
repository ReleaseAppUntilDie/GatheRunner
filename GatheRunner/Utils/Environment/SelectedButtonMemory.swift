//
//  SelectedButtonMemory.swift
//  GatheRunner
//
//  Created by cho on 2022/10/15.
//

import SwiftUI

class SelectedButtonMemory: ObservableObject {
    @Published var selectedButton: ButtonName = .justStartButton
}

extension SelectedButtonMemory {
    enum ButtonName {
        case justStartButton
        case runGuideButton
    }
}
