//
//  HistoryList.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/10/10.
//

import SwiftUI

// MARK: - HistoryList

struct HistoryList: View {
    @ObservedObject var viewModel: GraphViewModel
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
            VStack(alignment: .leading) {
                Text("최근 활동")
                    .font(.title3)
                    .padding()
                    .padding(.leading,20)
                
                LazyVStack {
                    ForEach(viewModel.historyModels, id: \.self) { HistoryItem(history: $0) }
                }
            }
        }
    }
}
