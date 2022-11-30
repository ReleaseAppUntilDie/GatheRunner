//
//  BottomSheetView.swift
//  GatheRunner
//
//  Created by hanjaeseung on 2022/09/18.
//

import SwiftUI

// MARK: - GraphBottomSheetView

struct GraphBottomSheetView: View {
    
    // MARK: Lifecycle
    
    init(
        viewModel: GraphViewModel,
        show: Binding<Bool>,
        selectedTimeUnit: Binding<TimeUnit>)
    {
        self.viewModel = viewModel
        _show = show
        _selectedTimeUnit = selectedTimeUnit
        
        let current = Date().get([.year,.month])
        selectedYear = current.year ?? 0
        selectedMonth = current.month ?? 0
     
    }
    
    // MARK: Internal
    
    @ObservedObject var viewModel: GraphViewModel
    @State var selected = "이번주"
    @State var selectedMonth: Int
    @State var selectedYear: Int
    @Binding var show: Bool
    @Binding var selectedTimeUnit: TimeUnit
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(show ? 0.5 : 0)
                .edgesIgnoringSafeArea(.top)
                .onTapGesture {
                    withAnimation(.linear) {
                        show.toggle()
                    }
                }
            
            LazyVStack {
                PickerView(
                    viewModel: viewModel,
                    selected: $selected,
                    selectedMonth: $selectedMonth,
                    selectedYear: $selectedYear,
                    timeUnit: selectedTimeUnit)
                .padding()
                Button {
                    confirmButtonAction()
                } label: {
                    Text("선택")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.getWidthby(ratio: 0.8), height: 50, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 25).fill(Color.black))
                }
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.getHeightby(ratio: 0.5))
            .transition(.slide)
            .background(Color.white)
            .cornerRadius(16, corners: [.topLeft,.topRight])
        }
    }
    
    func confirmButtonAction() {
        viewModel.updatePeriodText(
            selectedStr: selected,
            selectedYear: selectedYear,
            selectedMonth: selectedMonth
        )
        withAnimation(.linear) {
            show.toggle()
        }
    }
}

// MARK: - PickerView

struct PickerView: View {
    
    @ObservedObject var viewModel: GraphViewModel
    @Binding var selected: String
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int
    var timeUnit: TimeUnit
    
    var body: some View {
        if timeUnit == .week {
            Picker("Choose period", selection: $selected) {
                ForEach(viewModel.pickerItemList,id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.wheel)
        } else if timeUnit == .month {
            HStack(spacing: 0) {
                Picker("Choose year", selection: $selectedYear) {
                    ForEach(viewModel.pickerItemListInMonth.0,id: \.self) {
                        Text(verbatim: "\($0)년")
                    }
                }
                .frame(width: UIScreen.getWidthby(ratio: 0.5))
                .pickerStyle(.wheel)

                Picker("Choose month", selection: $selectedMonth) {
                    ForEach(viewModel.pickerItemListInMonth.1,id: \.self) {
                        Text("\($0)월")
                    }
                }
                .frame(width: UIScreen.getWidthby(ratio: 0.5))
                .pickerStyle(.wheel)
            }
        } else if timeUnit == .year {
            Picker("Choose period", selection: $selectedYear) {
                ForEach(viewModel.pickerListYear, id: \.self) {
                    Text(verbatim: "\($0)년")
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

// MARK: - BottomSheetView_Previews

// struct BottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        GraphBottomSheetView(show: .constant(true),selectedTimeUnit: .constant(.week))
//    }
// }