//
//  GraphView.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/07/29.
//

import SwiftUI

// MARK: - TimeUnit

enum TimeUnit {
    case week,month,year,whole
}

// MARK: - GraphView

struct GraphView: View {

    // MARK: Internal

    @State private var isPickerViewShowed = false
    @ObservedObject var viewModel = GraphViewModel()

    var body: some View {
        ZStack {
            VStack(alignment:.leading) {
                PeriodView(curTimeUnit: $selectedTimeUnit)
                    .padding(.bottom)
                    .onTouch(type: .started) { point in
                        withAnimation {
                            setTimeUnit(by: point.x)
                        }
                    }
                // TODO: Picker 아이템 생성후 삽입
                SimplifiedStatistics(
                    viewModel: viewModel,
                    selectedTimeUnit: $selectedTimeUnit,
                    pickerViewShowed: $isPickerViewShowed)

                Graph(
                    graphWidth: UIScreen.getWidthby(ratio: 0.7),
                    cellHeight: UIScreen.getHeightby(ratio: 0.035),
                    viewModel: viewModel)

            }.padding(.leading,UIScreen.getWidthby(ratio: 0.1))

            GraphBottomSheetView(
                viewModel: viewModel,
                show: $isPickerViewShowed,
                selectedTimeUnit: $selectedTimeUnit)
        }
    }

    func setTimeUnit(by x: CGFloat) {
        if x < UIScreen.getWidthby(ratio: 0.2) {
            selectedTimeUnit = .week
        } else if x >= UIScreen.getWidthby(ratio: 0.2),x < UIScreen.getWidthby(ratio: 0.4) {
            selectedTimeUnit = .month
        } else if x >= UIScreen.getWidthby(ratio: 0.4),x < UIScreen.getWidthby(ratio: 0.6) {
            selectedTimeUnit = .year
        } else {
            selectedTimeUnit = .whole
        }
    }

    func viewModelUpdate() {
        viewModel.updateTimeUnit(selectedTimeUnit)
        viewModel.updatePicker(timeUnit: selectedTimeUnit)
        viewModel.fetchData()
    }

    // MARK: Private

    @State private var selectedTimeUnit: TimeUnit = .week {
        didSet {
            viewModelUpdate()
        }
    }
}

// MARK: - GraphView_Previews

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
