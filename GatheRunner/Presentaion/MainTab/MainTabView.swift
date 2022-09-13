//
//  ContentView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

// MARK: - MainTabView

struct MainTabView: View {
    @ObservedObject var selectedTab = SelectedTab.shared

    var body: some View {
        TabView(selection: $selectedTab.index) {
            ForEach(tabItems) { createTabView($0) }
                .environmentObject(selectedTab)
        }
        .accentColor(.black)
    }
}

// MARK: - TabItem Property and Functions

extension MainTabView {
    private var tabItems: [TabItem] {
        Component.allCases.map { $0.madeTabItem }
    }

    // MARK: - selectedView & createTabView 다시 한번 체크

    private func selectedView(_ tag: Int) -> some View {
        Group {
            switch tag {
            case 1: HomeView()
            case 2: RunningView()
            case 3: ClubView()
            case 4: ActivityView()
            default: HomeView()
            }
        }
    }

    private func createTabView(_ tabItem: TabItem) -> some View {
        NavigationView { selectedView(tabItem.tag).navigationBarHidden(true) }
            .tabItem {
                Label(title: { tabItem.title }, icon: { tabItem.icon })
            }
            .tag(tabItem.tag)
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

extension MainTabView {
    enum Component: String, CaseIterable {
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

        var madeTabItem: TabItem {
            TabItem(title: Text(rawValue), icon: icon, tag: tag)
        }
    }
}
