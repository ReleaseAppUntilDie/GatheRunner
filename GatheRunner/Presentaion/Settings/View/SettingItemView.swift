//
//  SettingItemView.swift
//  GatheRunner
//
//  Created by Atlas on 2022/07/12.
//

import SwiftUI

// MARK: - SettingItemView

struct SettingItemView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Text("측정")
                    .frame(height: 50, alignment: .center)
                Spacer()
            }.background(Color.mint)

            Group {
                HStack {
                    TemplateView(type: .indoorOutdoor)
                    TemplateView(type: .autoPause)
                }
            }
        }
    }
}

// MARK: - SettingItemView_Previews

struct SettingItemView_Previews: PreviewProvider {
    static var previews: some View {
        SettingItemView()
    }
}
