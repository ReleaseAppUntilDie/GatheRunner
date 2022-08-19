//
//  HomeView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

// MARK: - HomeView

struct HomeView: View {
    @EnvironmentObject var selectedTab: SelectedTab

    var body: some View {
        // MARK: - Add TabEvent Action Example

        Button { } label: {
            Image(systemName: "plus")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.black)
                .frame(width: 25, height: 25)
        }
        .environmentObject(selectedTab)
        .buttonStyle(TabBarButton(TabItem.MainComponent.run.tag))
        .accessibilityIdentifier("ButtonTest")
    }
}

// MARK: - HomeView_Previews

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
