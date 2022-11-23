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
            if !viewModel.fetchError {
                VStack(alignment: .leading) {
                    Text("최근 활동")
                        .font(.title3)
                        .padding()
                        .padding(.leading,20)
                    LazyVStack {
                        ForEach(Array(viewModel.historys.enumerated()), id: \.offset) { index, history in
                            HistoryItem(
                                history: history
                            )
                        }
                    }
                }
            } else {
                Spacer()
                
                Text("기록이 없습니다")
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
            }
        }
    }
}
