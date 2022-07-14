//
//  ViewModel.swift
//  GatheRunner
//
//  Created by Atlas on 2022/07/12.
//

import SwiftUI

class SettingModel {
    var status: String
    var description: String
    var imageIconName: String
    var alignment: Alignment
    var iconImageHidden: Bool
    var statusTextHidden: Bool
    var descriptionTextHidden: Bool
    
    init(type: SettingType){
        switch type {
        case .indoorOutdoor(let status, let description, let icon, let alignment, let iconImageHidden, let statusTextHidden, let descriptionTextHidden):
            self.status = status
            self.description = description
            self.imageIconName = icon
            self.alignment = alignment
            self.iconImageHidden = iconImageHidden
            self.statusTextHidden = statusTextHidden
            self.descriptionTextHidden = descriptionTextHidden
        case .autoPause(let status, let description, let icon, let alignment, let iconImageHidden, let statusTextHidden, let descriptionTextHidden):
            self.status = status
            self.description = description
            self.imageIconName = icon
            self.alignment = alignment
            self.iconImageHidden = iconImageHidden
            self.statusTextHidden = statusTextHidden
            self.descriptionTextHidden = descriptionTextHidden
        case .audioFeedback(let status, let description, let icon, let alignment, let iconImageHidden, let statusTextHidden, let descriptionTextHidden):
            self.status = status
            self.description = description
            self.imageIconName = icon
            self.alignment = alignment
            self.iconImageHidden = iconImageHidden
            self.statusTextHidden = statusTextHidden
            self.descriptionTextHidden = descriptionTextHidden
        case .countDown(let status, let description, let icon, let alignment, let iconImageHidden, let statusTextHidden, let descriptionTextHidden):
            self.status = status
            self.description = description
            self.imageIconName = icon
            self.alignment = alignment
            self.iconImageHidden = iconImageHidden
            self.statusTextHidden = statusTextHidden
            self.descriptionTextHidden = descriptionTextHidden
        case .orientation(let status, let description, let icon, let alignment, let iconImageHidden, let statusTextHidden, let descriptionTextHidden):
            self.status = status
            self.description = description
            self.imageIconName = icon
            self.alignment = alignment
            self.iconImageHidden = iconImageHidden
            self.statusTextHidden = statusTextHidden
            self.descriptionTextHidden = descriptionTextHidden
        case .display(let status, let description, let icon, let alignment, let iconImageHidden, let statusTextHidden, let descriptionTextHidden):
            self.status = status
            self.description = description
            self.imageIconName = icon
            self.alignment = alignment
            self.iconImageHidden = iconImageHidden
            self.statusTextHidden = statusTextHidden
            self.descriptionTextHidden = descriptionTextHidden
        }
    }
}

typealias ViewType = SettingModel.SettingType

extension SettingModel {
    enum SettingType {
        case indoorOutdoor(status: String = "Outdoor", description: String = "Indoor/Outdoor", icon:String = "location.fill", alignment: Alignment = .center , iconImageHidden: Bool = false, statusTextHidden:Bool = false, descriptionTextHidden: Bool = false)
        case autoPause(status: String = "On", description: String = "Auto-Pause", icon:String = "pause.fill", alignment: Alignment = .center , iconImageHidden: Bool = false, statusTextHidden:Bool = false, descriptionTextHidden: Bool = false)
        case audioFeedback(status: String = "Portrait", description: String = "On/Female", icon:String = "speaker.wave.2.fill", alignment: Alignment = .center , iconImageHidden: Bool = false, statusTextHidden:Bool = false, descriptionTextHidden: Bool = false)
        case countDown(status: String = "3 Seconds", description: String = "Countdown", icon:String = "stopwatch", alignment: Alignment = .center , iconImageHidden: Bool = false, statusTextHidden:Bool = false, descriptionTextHidden: Bool = false)
        case orientation(status: String = "Portrait", description: String = "Orientation", icon:String = "iphone", alignment: Alignment = .center , iconImageHidden: Bool = false, statusTextHidden:Bool = false, descriptionTextHidden: Bool = false)
        case display(status: String = "Run Level Color", description: String = "Display", icon:String = "platter.filled.top.iphone", alignment: Alignment = .center , iconImageHidden: Bool = false, statusTextHidden:Bool = false, descriptionTextHidden: Bool = false)
    }
}
