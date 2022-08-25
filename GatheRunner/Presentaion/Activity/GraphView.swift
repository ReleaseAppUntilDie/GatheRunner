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

    var body: some View {
        VStack {
            TimeUnitsTable(curTimeUnit: $selectedTimeUnit)
                .onTouch(type: .started) { point in
                    withAnimation {
                        setTimeUnitby(x: point.x)
                    }
                }
            // TODO: Picker 아이템 생성후 삽입
            SimplifiedStatistics(selectedTimeUnit: $selectedTimeUnit)
        }
    }



    func setTimeUnitby(x: CGFloat) {
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

    // MARK: Private

    @State private var selectedTimeUnit: TimeUnit = .week
}

// MARK: - TimeUnitsTable


struct TimeUnitsTable: View {

    @Binding var curTimeUnit: TimeUnit


    var unitIndex: Double {
        switch curTimeUnit {
        case .week:return 0
        case .month:return 1
        case .year:return 2
        case .whole:return 3
        }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: UIScreen.getHeightby(ratio: 0.02))
                .strokeBorder(Color(uiColor: .systemGray4),lineWidth: 2)
                .frame(width: UIScreen.getWidthby(ratio: 0.8), height: UIScreen.getHeightby(ratio: 0.04))

            ZStack {
                RoundedRectangle(cornerRadius: UIScreen.getHeightby(ratio: 0.02))
                    .fill(Color.green)
                    .frame(width: UIScreen.getWidthby(ratio: 0.2), height: UIScreen.getHeightby(ratio: 0.04))
                    .offset(x: -UIScreen.getWidthby(ratio: 0.3) + UIScreen.getWidthby(ratio: 0.2 * unitIndex))
                HStack(spacing:0) {
                    Text("주")
                        .foregroundColor(curTimeUnit == .week ? .black : .init(uiColor: .systemGray2))
                        .frame(width: UIScreen.getWidthby(ratio: 0.2))
                    Text("월")
                        .foregroundColor(curTimeUnit == .month ? .black : .init(uiColor: .systemGray2))
                        .frame(width: UIScreen.getWidthby(ratio: 0.2))
                    Text("년")
                        .foregroundColor(curTimeUnit == .year ? .black : .init(uiColor: .systemGray2))
                        .frame(width: UIScreen.getWidthby(ratio: 0.2))
                    Text("전체")
                        .foregroundColor(curTimeUnit == .whole ? .black : .init(uiColor: .systemGray2))
                        .frame(width: UIScreen.getWidthby(ratio: 0.2))
                }
            }
        }
    }

}

// MARK: - SimplifiedStatistics


struct SimplifiedStatistics: View {

    // MARK: Lifecycle

    init(selectedTimeUnit: Binding<TimeUnit>) {
        _selectedTimeUnit = selectedTimeUnit
    }

    // MARK: Internal

    var test = ["1","2","3","4"]
    @Binding var selectedTimeUnit: TimeUnit


    var buttonText: String {
        switch selectedTimeUnit {
        case .week:return "이번주"
        case .month:return "2022년 8월"
        case .year:return "2022년"
        case .whole:return "2020년~2022년"
        }
    }

    var body: some View {
        VStack(alignment: .leading,spacing: UIScreen.getHeightby(ratio: 0.02)) {
            Button { } label: {
                HStack {
                    Text(buttonText)
                        .foregroundColor(.black)
                    Image(systemName: "chevron.down")
                        .isEmpty(logicalOperator: .and, [selectedTimeUnit != .whole])
                }
            }
            .disabled(selectedTimeUnit == .whole)
            .foregroundColor(.black)
            Text("10.0")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Text("킬로미터")
                .foregroundColor(.gray)
                .font(.system(size: 12))
            Picker("test",selection: $selected) {
                ForEach(test,id:\.self) {
                    Text($0)
                }
            }
        }
        .pickerStyle(WheelPickerStyle())
        .padding(.horizontal,UIScreen.getWidthby(ratio: 0.1))
    }

    // MARK: Private

    @State private var selected = ""
}

// MARK: - GraphView_Previews

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
