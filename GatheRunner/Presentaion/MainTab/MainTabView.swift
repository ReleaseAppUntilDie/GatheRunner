//
//  ContentView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

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
        [TabItem(.home), TabItem(.run), TabItem(.club), TabItem(.activity)]
    }
    
    private func selectedView(_ tag: Int) -> AnyView {
        switch tag {
        case 1: return AnyView(HomeView())
        case 2: return AnyView(RunningView())
        case 3: return AnyView(ClubView())
        case 4: return AnyView(ActivityView())
        default: return AnyView(HomeView())
            
        }
    }
    
    private func createTabView(_ tabItem: TabItem) -> some View {
        NavigationView { selectedView(tabItem.tag) }
        .tabItem {
            Label(title: { tabItem.title }, icon: { tabItem.icon } )
        }
        .tag(tabItem.tag)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
