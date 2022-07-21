//
//  HomeView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var selectedTab: SelectedTab

    var body: some View {
        Button("test") { }
        .tabBarBtnStyle(tabIndex: TabItem.MainComponent.run.tag, iconName: "1.circle")
        .environmentObject(selectedTab)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
