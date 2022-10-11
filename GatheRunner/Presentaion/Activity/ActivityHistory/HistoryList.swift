//
//  HistoryList.swift
//  GatheRunner
//
//  Created by 김현미 on 2022/10/10.
//

import SwiftUI

// MARK: - HistoryList

struct HistoryList: View {
    var body: some View {
        ZStack {
            Color(uiColor: .lightGray)
            VStack {
                Text("최근 활동")
                    .font(.title2)
                    .padding()
                LazyVStack {
                    ForEach(0...10,id: \.self) { _ in
                        HistoryItem()
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
