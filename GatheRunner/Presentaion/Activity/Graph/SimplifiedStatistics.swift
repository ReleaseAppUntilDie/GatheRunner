//
//  SimplifiedStatistics.swift
//  GatheRunner
//
//  Created by 김현진 on 2022/09/06.
//

import SwiftUI

// MARK: - SimplifiedStatistics

struct SimplifiedStatistics: View {

    // MARK: Lifecycle

    init(selectedTimeUnit: Binding<TimeUnit>,pickerViewShowed: Binding<Bool>) {
        _selectedTimeUnit = selectedTimeUnit
        _pickerViewShowed = pickerViewShowed
    }

    // MARK: Internal

    @Binding var selectedTimeUnit: TimeUnit
    @Binding var pickerViewShowed: Bool
    let distance = "10.0"
    let distanceUnit = "킬로미터"
    let runningCnt = 6
    let averagePace = "5'41''"
    let totalTime = "2:54:51"

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
            Button {
                guard selectedTimeUnit != .whole else { return }
                withAnimation(.linear) {
                    pickerViewShowed.toggle()
                }

            } label: {
                HStack {
                    Text(buttonText)
                        .foregroundColor(.black)
                    Image(systemName: "chevron.down")
                        .isEmpty(logicalOperator: .and, [selectedTimeUnit != .whole])
                }
            }
            .disabled(selectedTimeUnit == .whole)
            .foregroundColor(.black)
            Text(distance)
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Text(distanceUnit)
                .foregroundColor(.gray)
                .font(.system(size: 12))
            HStack(spacing: 40) {
                runningCountView(cnt: runningCnt)
                averagePaceView(pace: averagePace)
                totalTimeView(time: totalTime)
            }
        }
    }

}

extension SimplifiedStatistics {
    @ViewBuilder
    func averagePaceView(pace: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(pace)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            Text("평균 페이스")
                .foregroundColor(.gray)
                .font(.system(size: 12))
        }
    }

    @ViewBuilder
    func totalTimeView(time: String)-> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(time)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            Text("시간")
                .foregroundColor(.gray)
                .font(.system(size: 12))
        }
    }

    @ViewBuilder
    func runningCountView(cnt: Int) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(cnt)")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            Text("러닝")
                .foregroundColor(.gray)
                .font(.system(size: 12))
        }
    }

}

// MARK: - SimplifiedStatistics_Previews

struct SimplifiedStatistics_Previews: PreviewProvider {
    static var previews: some View {
        SimplifiedStatistics(selectedTimeUnit: .constant(.week), pickerViewShowed: .constant(true))
    }
}
