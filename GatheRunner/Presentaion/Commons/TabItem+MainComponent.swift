//
//  TabItem+MainComponent.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

extension TabItem {

    // MARK: Lifecycle


    init(_ component: TabItem.MainComponent) {
        self.init(title: Text(component.rawValue), icon: component.icon, tag: component.tag)
    }

    // MARK: Internal

    enum MainComponent: String {
        case home = "홈"
        case run = "러닝"
        case club = "클럽"
        case activity = "활동"

        // MARK: Internal


        var icon: Image {
            switch self {
            case .home: return Image(systemName: "house.fill")
            case .run: return Image(systemName: "person.crop.circle")
            case .club: return Image(systemName: "person.icloud.fill")
            case .activity: return Image(systemName: "record.circle.fill")
            }
        }

        var tag: Int {
            switch self {
            case .home: return 1
            case .run: return 2
            case .club: return 3
            case .activity: return 4
            }
        }
    }
}
