//
//  TabItem+MainOption.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

extension TabItem {
    enum MainOption: String {
        case home = "홈"
        case run = "러닝"
        case club = "클럽"
        case activity = "활동"
        
        var view: AnyView {
            switch self {
            case .home: return AnyView(HomeView())
            case .run: return AnyView(RunningView())
            case .club: return AnyView(ClubView())
            case .activity: return AnyView(ActivityView())
            }
        }
        
        var title: Text {
            Text(self.rawValue)
        }
        
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
    
    init(_ option: TabItem.MainOption) {
        self.init(view: option.view, title: option.title, icon: option.icon, tag: option.tag)
    }
}
