//
//  ContentView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

// MARK: - MainTabView

struct MainTabView: View {
    private enum Content {
        enum Image {
            static let run = "person.crop.circle"
            static let activity = "record.circle.fill"
        }
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab.mainIndex) {
                ForEach(tabItems) { childView($0).environmentObject(container) }
            }
            .onAppear { didSetTabBar() }
            .accentColor(.black)
        }
    }
    
    @EnvironmentObject var container: DependencyContainer
    @ObservedObject var selectedTab = SelectedTab.shared
}

extension MainTabView {
    private var tabItems: [TabItem] {
        MainTabComponents.allCases.map { TabItem(title: Text($0.rawValue), icon: tabIcon($0), tag: $0.tag) }
    }
    
    private func tabIcon(_ tag: MainTabComponents) -> Image {
        switch tag {
        case .run: return Image(systemName: Content.Image.run)
        case .activity: return Image(systemName: Content.Image.activity)
        }
    }
    
    private func selectedView(_ tag: Int) -> some View {
        Group {
            switch tag {
            case 1: RunningView()
            case 2: ActivityView()
            default: EmptyView()
            }
        }
    }
    
    private func childView(_ tabItem: TabItem) -> some View {
        selectedView(tabItem.tag)
            .navigationBarHidden(true)
            .tabItem { Label(title: { tabItem.title }, icon: { tabItem.icon }) }
            .tag(tabItem.tag)
    }
    
    private func didSetTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
