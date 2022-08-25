//
//  ViewModel.swift
//  GatheRunner
//
//  Created by Atlas on 2022/07/12.
//

import SwiftUI

// MARK: - SettingModel

struct SettingModel {
    let status: String
    let description: String
    let imageIconName: String
}

typealias ViewType = SettingModel.SettingType

extension SettingModel {

    // MARK: Lifecycle



    init(_ component: SettingModel.SettingType) {
        self.init(status: component.status, description: component.rawValue, imageIconName: component.imageIconName)
    }

    // MARK: Internal

    enum SettingType: String {

        case indoorOutdoor = "Indoor/Outdoor"
        case autoPause = "Auto-Pause"
        case audioFeedback = "Portrait"
        case countDown = "Countdown"
        case orientation = "Orientation"
        case display = "Display"

        // MARK: Internal


        var status: String {
            switch self {
            case .indoorOutdoor :
                return "Outdoor"
            case .autoPause :
                return "On"
            case .audioFeedback :
                return "On/Female"
            case .countDown :
                return "3 Seconds"
            case .orientation :
                return "Portrait"
            case .display :
                return "Run Level Color"
            }
        }

        var imageIconName: String {
            switch self {
            case .indoorOutdoor :
                return "location.fill"
            case .autoPause :
                return "pause.fill"
            case .audioFeedback :
                return "speaker.wave.2.fill"
            case .countDown :
                return "stopwatch"
            case .orientation :
                return "iphone"
            case .display :
                return "platter.filled.top.iphone"
            }
        }
    }
}
