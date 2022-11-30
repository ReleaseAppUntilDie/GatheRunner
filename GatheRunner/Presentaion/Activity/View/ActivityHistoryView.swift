//
//  ActivityHistoryView.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/08/24.
//

import SwiftUI

// MARK: - TimeUnit

enum TimeUnit {
    case week,month,year,whole
}

// MARK: - ActivityHistoryView

struct ActivityHistoryView: View {
    @StateObject var viewModel: GraphViewModel
    @State private var isPickerViewShowed = false
    @State var selectedTimeUnit: TimeUnit = .week
    
    var body: some View {
        ZStack {
            ScrollView {
                GraphView(
                    isPickerViewShowed: $isPickerViewShowed,
                    viewModel: viewModel,
                    selectedTimeUnit: $selectedTimeUnit
                )
                
                HistoryList
            }
            .padding(.top)
            
            GraphBottomSheetView(
                viewModel: viewModel,
                show: $isPickerViewShowed,
                selectedTimeUnit: $selectedTimeUnit
            )
                .isEmpty(logicalOperator: .none, [isPickerViewShowed])
        }
    }
    
    private var HistoryList: some View {
        ZStack {
            Color(uiColor: .systemGray6)
            VStack(alignment: .leading) {
                Text("최근 활동")
                    .font(.title3)
                    .padding()
                    .padding(.leading,20)
                
                LazyVStack {
                    ForEach(viewModel.historys, id: \.self) { HistoryItem(history: $0) }
                }
                .padding(.bottom)
            }
        }
    }
}

// MARK: - ActivityHistoryView_Previews
//
struct ActivityHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityHistoryView(viewModel: DependencyContainer.previewGraphScene)
    }
}
