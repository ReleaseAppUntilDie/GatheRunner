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

    @ObservedObject var viewModel = GraphViewModel()
    @State private var isPickerViewShowed = false
    @State var selectedTimeUnit: TimeUnit = .week

    var body: some View {
        ZStack {
            ScrollView {
                GraphView(isPickerViewShowed: $isPickerViewShowed, viewModel: viewModel, selectedTimeUnit: $selectedTimeUnit)
                HistoryList()
            }.padding(.top)
            GraphBottomSheetView(
                viewModel: viewModel,
                show: $isPickerViewShowed,
                selectedTimeUnit: $selectedTimeUnit
            )
            .isEmpty(logicalOperator: .none, [isPickerViewShowed])
        }
    }
}

// MARK: - ActivityHistoryView_Previews

struct ActivityHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityHistoryView()
    }
}
