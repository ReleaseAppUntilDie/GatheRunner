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
    let recrod: RunningRecordResponse
    @State var hasBadge = true

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
                        Text(recrod.date ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        
//                        Text(history.weekday)
//                            .font(.system(size: 14))
//                            .foregroundColor(.gray)
                    }
                }

                HStack(spacing: 20) {
                    element(title: recrod.distance ?? "0", sub: "Km")
                    element(title: recrod.averagePace ?? "0", sub: "평균 페이스")
                    element(title: recrod.runningTime ?? "0", sub: "시간")
                }
                Group {
                    Rectangle()
                        .strokeBorder(Color.gray,lineWidth: 1)
                        .frame(height: 1)

                    Image(systemName: "star.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }.isEmpty(logicalOperator: .none, [hasBadge])
            }
            .padding(.horizontal,20)
            .padding(.vertical,10)
        }
        .frame(width: UIScreen.getWidthby(ratio: 0.8))
        .cornerRadius(10)
    }

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

// struct HistoryItem_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryItem()
//    }
// }
