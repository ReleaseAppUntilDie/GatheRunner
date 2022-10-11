//
//  HistoryItem.swift
//  GatheRunner
//
//  Created by hanjaeseung on 2022/10/10.
//

import SwiftUI

// MARK: - HistoryItem

struct HistoryItem: View {

    let iconImageName = "map"
    let timeString = "2022.10.7."
    let weekString = "금요일 저녁 러닝"
    let distance = "8.00"
    let averagePace = "5'13''"
    let runningTime = "41:44"

    var body: some View {
        ZStack(alignment: .leading) {
            Color.white
            VStack(alignment: .leading,spacing: 15) {
                HStack {
                    Image(systemName: iconImageName)
                        .frame(width: 30, height: 30)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .strokeBorder(.black,lineWidth: 1))
                    VStack(alignment: .leading) {
                        Text(timeString)
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        Text(weekString)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }

                HStack(spacing: 20) {
                    element(title: distance, sub: "Km")
                    element(title: averagePace, sub: "평균 페이스")
                    element(title: runningTime, sub: "시간")
                }
            }
            .padding(.leading,20)
            .padding(.vertical,10)
        }
        .frame(width: UIScreen.getWidthby(ratio: 0.8))
        .cornerRadius(10)
    }

    @ViewBuilder
    func element(title: String, sub: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
            Text(sub)
                .font(.system(size: 14))
        }
    }
}

// MARK: - HistoryItem_Previews

struct HistoryItem_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItem()
    }
}
