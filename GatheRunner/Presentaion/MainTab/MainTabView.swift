//
//  ContentView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(tabs) { tabItem in
                NavigationView {
                    tabItem.view
                }
                .tabItem {
                    tabItem.title
                    tabItem.icon
                }
                .tag(tabItem.tag)
                
            }
        }
        .accentColor(.black)
    }
}

extension MainTabView {
    private var tabs: [TabItem] {
        [TabItem(.home), TabItem(.run), TabItem(.club), TabItem(.activity)]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
