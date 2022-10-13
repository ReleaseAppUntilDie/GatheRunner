//
//  HistoryList.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/10/10.
//

import SwiftUI

// MARK: - HistoryList

struct HistoryList: View {
    var body: some View {
        ZStack {
            Color(uiColor: .lightGray)
            VStack(alignment: .leading) {
                Text("최근 활동")
                    .font(.title3)
                    .padding()
                    .padding(.leading,20)
                LazyVStack {
                    ForEach(0...10,id: \.self) { _ in
                        HistoryItem(history: History(
                            timeString: "2022.10.7.", weekString: "금요일 저녁 러닝", distance: "8.00", averagePace: "5'13''",
                            runningTime: "41:44"))
                    }
                }
            }
        }
    }
}

// MARK: - HistoryList_Previews

struct HistoryList_Previews: PreviewProvider {
    static var previews: some View {
        HistoryList()
    }
}
