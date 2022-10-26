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
        case run = "러닝"
        case activity = "활동"

        // MARK: Internal

        var icon: Image {
            switch self {
            case .run: return Image(systemName: "flame.circle")
            case .activity: return Image(systemName: "list.bullet.below.rectangle")
            }
        }

        var tag: Int {
            switch self {
            case .run: return 1
            case .activity: return 2
            }
        }
    }
}
