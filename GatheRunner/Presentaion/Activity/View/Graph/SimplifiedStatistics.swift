//
//  SimplifiedStatistics.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/09/06.
//

import SwiftUI

// MARK: - SimplifiedStatistics

struct SimplifiedStatistics: View {

    @ObservedObject var viewModel: GraphViewModel
    @Binding var selectedTimeUnit: TimeUnit
    @Binding var pickerViewShowed: Bool

    let averageHistory: (distance: Int, count: Int, pace: String, totalTime: String)

    var buttonText: String {
        switch selectedTimeUnit {
        case .week: return "이번주"
        case .month: return "2022년 8월"
        case .year: return "2022년"
        case .whole: return "2020년~2022년"
        }
    }

    var body: some View {
        VStack(alignment: .leading,spacing: UIScreen.getHeightby(ratio: 0.02)) {
            Button {
                guard selectedTimeUnit != .whole else { return }

                withAnimation(.easeOut(duration: 0.5)) {
                    pickerViewShowed.toggle()
                }
            } label: {
                HStack {
                    Text(viewModel.selectedString)
                        .foregroundColor(.black)
                    Image(systemName: "chevron.down")
                        .isEmpty(logicalOperator: .and, [selectedTimeUnit != .whole])
                }
            }
            .disabled(selectedTimeUnit == .whole)
            .foregroundColor(.black)
            Text(String(averageHistory.distance))
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Text("킬로미터")
                .foregroundColor(.gray)
                .font(.system(size: 12))
            HStack(spacing: 40) {
                runningCountView(cnt: averageHistory.count)
                averagePaceView(pace: averageHistory.pace)
                totalTimeView(time: averageHistory.totalTime)
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
//
// struct SimplifiedStatistics_Previews: PreviewProvider {
//    static var previews: some View {
//        SimplifiedStatistics(selectedTimeUnit: .constant(.week), pickerViewShowed: .constant(true))
//    }
// }
