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
                        ForEach(viewModel.historys ?? []) { history in
                            HistoryItem(history: history)
                        }
                    }
                    .padding(.bottom)
                }
            } else {
                Spacer()
                
                Text("기록을 불러오지 못했습니다.")
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
            }
        }
    }
}
