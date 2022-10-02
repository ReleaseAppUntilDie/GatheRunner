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

        let current = Calendar.current.dateComponents([.year,.month], from: Date())
        selectedYear = current.year!
        selectedMonth = current.month!
    }


    // MARK: Internal

    @ObservedObject var viewModel: GraphViewModel
    @State var selected = ""
    @State var selectedMonth: Int
    @State var selectedYear: Int
    @Binding var show: Bool
    @Binding var selectedTimeUnit: TimeUnit

    var body: some View {
        ZStack(alignment:.bottom) {
            Color.black.opacity(show ? 0.5 : 0)
                .edgesIgnoringSafeArea(.top)
                .onTapGesture {
                    withAnimation(.linear) {
                        show.toggle()
                    }
                }

            VStack {
                PickerView(
                    viewModel: viewModel,
                    selected: $selected,
                    selectedMonth: $selectedMonth,
                    selectedYear: $selectedYear,
                    isMonth: selectedTimeUnit == .month)
                    .padding()
                Button {
                    viewModel.updateSelected(selectedStr: selected, selectedYear: selectedYear, selectedMonth: selectedMonth)
                    viewModel.fetchData()
                    withAnimation(.linear) {
                        show.toggle()
                    }
                } label: {
                    Text("선택")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.getWidthby(ratio: 0.8), height: 50, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 25).fill(Color.black))
                }
            }
            .frame(width: UIScreen.screenWidth)
            .frame(maxHeight: show ? UIScreen.getHeightby(ratio: 0.5) : 0)
            .background(Color.white)
            .cornerRadius(16, corners: [.topLeft,.topRight])
        }
    }
}

// MARK: - PickerView

struct PickerView: View {

    @ObservedObject var viewModel: GraphViewModel
    @Binding var selected: String
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int
    var isMonth: Bool

    var body: some View {
        if !isMonth {
            Picker("Choose period", selection: $selected) {
                ForEach(viewModel.pickerItemList,id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.wheel)
        } else {
            HStack(spacing: 0) {
                Picker("Choose year", selection: $selectedYear) {
                    ForEach(viewModel.pickerItemListInMonth.0,id: \.self) {
                        Text("\($0)년")
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
        }
    }
}

// MARK: - BottomSheetView_Previews

// struct BottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        GraphBottomSheetView(show: .constant(true),selectedTimeUnit: .constant(.week))
//    }
// }
