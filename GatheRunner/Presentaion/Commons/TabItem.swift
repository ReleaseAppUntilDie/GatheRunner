//
//  TabItem.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

struct TabItem: Identifiable {
    let id = UUID()
    let view: AnyView
    let title: Text
    let icon: Image
    let tag: Int
    
    var body: some View {
        NavigationView { self.view }
        .tabItem {
            Label(title: { self.title }, icon: { self.icon } )
        }
        .tag(self.tag)
    }
}
