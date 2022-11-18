//
//  JustStartView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

// MARK: - JustStartView

struct JustStartView: View {
    @State private var isPresentedRunGuideDetailDescriptionView = false
    @StateObject var getWeatherInfo: WeatherInfoViewModel = WeatherInfoViewModel()

    var body: some View {
        ZStack {
            MapView().hide(isPresentedRunGuideDetailDescriptionView)
            VStack {
                weatherInfoDisplay
                RunGuideTabView(isPresentedRunGuideDetailDescriptionView: $isPresentedRunGuideDetailDescriptionView).padding(0)
                Spacer()
                BottomButtonView().padding(.bottom, 30)
            }
        }
    }
}

extension JustStartView {
    @ViewBuilder
    private var weatherInfoDisplay: some View {
        let weatherInfoString = isWeatherInfoDataNotNil ? ("오늘의 운동 지수 : " + getWeatherInfo.outdoorGrade! + (Int(getWeatherInfo.outdoorGrade!)! >= 70 ? " ☀️☀️ " : " ☁️☁️ ") + getWeatherInfo.content!) : ""
        Rectangle().cornerRadius(7, corners: .allCorners)
            .frame(height: UIScreen.getHeightby(ratio: 0.03))
            .foregroundColor(.white)
            .overlay {
                Text(weatherInfoString)
                    .bold()
                    .kerning(2.0)
                    .lineSpacing(4.0)
                    .font(.system(size: 13))
            }
    }
    
    private var isWeatherInfoDataNotNil: Bool {
        if getWeatherInfo.outdoorGrade != nil && getWeatherInfo.content != nil {
            return true
        } else {
            return false
        }
    }
}

// MARK: - JustStartView_Previews

struct JustStartView_Previews: PreviewProvider {
    static var previews: some View {
        JustStartView()
    }
}
