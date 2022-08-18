//
//  SettingItemView.swift
//  GatheRunner
//
//  Created by Atlas on 2022/07/12.
//

import SwiftUI

<<<<<<< refs/remotes/origin/develop:GatheRunner/Presentaion/Settings/View/MeasurementView.swift
// MARK: - MeasurementView

struct MeasurementView: View {
=======
// MARK: - SettingItemView

struct SettingItemView: View {
>>>>>>> FEAT: 페이스 및 토글버튼 구현:GatheRunner/Presentaion/Settings/View/SettingItemView.swift
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

<<<<<<< refs/remotes/origin/develop:GatheRunner/Presentaion/Settings/View/MeasurementView.swift
// MARK: - MeasurementView_Previews

struct MeasurementView_Previews: PreviewProvider {
=======
// MARK: - SettingItemView_Previews

struct SettingItemView_Previews: PreviewProvider {
>>>>>>> FEAT: 페이스 및 토글버튼 구현:GatheRunner/Presentaion/Settings/View/SettingItemView.swift
    static var previews: some View {
        SettingItemView()
    }
}
