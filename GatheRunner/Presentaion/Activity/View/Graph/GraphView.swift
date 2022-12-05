//
//  GraphView.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/07/29.
//

import SwiftUI

// MARK: - GraphView

struct GraphView: View {
    
    @Binding var isPickerViewShowed: Bool
    @ObservedObject var viewModel: GraphViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                PeriodView(curTimeUnit: $selectedTimeUnit)
                    .padding(.bottom)
                    .onTouch(type: .started) { point in
                        withAnimation {
                            setTimeUnit(by: point.x)
                        }
                    }
                
                SimplifiedStatistics(
                    viewModel: viewModel,
                    selectedTimeUnit: $selectedTimeUnit,
                    pickerViewShowed: $isPickerViewShowed,
                    averageHistory: viewModel.totalRecord)
                
                Graph(
                    graphWidth: UIScreen.getWidthby(ratio: 0.7),
                    cellHeight: UIScreen.getHeightby(ratio: 0.035),
                    viewModel: viewModel)
                
            }
            .padding(.leading,UIScreen.getWidthby(ratio: 0.1))
        }
    }
    
    @Binding var selectedTimeUnit: TimeUnit {
        didSet {
            viewModelUpdate()
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
        viewModel.drawGraph()
    }
}
