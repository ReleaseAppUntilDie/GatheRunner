//
//  Graph.swift
//  GatheRunner
//
//  Created by hanjaeseung on 2022/09/06.
//

import SwiftUI

// MARK: - Graph

struct Graph: View {

    let graphWidth: CGFloat
    let cellHeight: CGFloat
    let lineWidth = 0.5
    let lineColor = Color(uiColor: .systemGray5)

    @ObservedObject var viewModel: GraphViewModel

    var barCornerRadius: CGFloat {
        switch viewModel.selectedTimeUnit {
        case .week:
            return 3
        case .month:
            return 0.5
        case .year:
            return 2
        case .whole:
            return 4
        }
    }

    var barWidth: CGFloat {
        switch viewModel.selectedTimeUnit {
        case .week:
            return 10
        case .month:
            return 3
        case .year:
            return 6
        case .whole:
            return 13
        }
    }

    var bottomLabels: [String] {
        switch viewModel.selectedTimeUnit {
        case .week:
            return ["월","화","수","목","금","토","일"]
        case .month:
            return Array(1...30).map { String($0) }
        case .year:
            return Array(1...12).map { "\($0)월" }
        case .whole:
            return viewModel.calculateYears().map { "\($0)년" }
        }
    }

    var maxValue: Int {
        (viewModel.records.max()! / 3 + 2) * 3
    }

    var secondV: Int {
        maxValue / 3 * 2
    }

    var thirdV: Int {
        maxValue / 3
    }

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
                ZStack(alignment: .topLeading) {
                    lineWithText(text: "\(maxValue)")
                    lineWithText(text: "\(secondV)")
                        .offset(y: cellHeight)
                    lineWithText(text: "\(thirdV)")
                        .offset(y: cellHeight * 2)
                    lineWithText(text: "0km")
                        .offset(y: cellHeight * 3)
                    graphOuterLine(startPos: CGPoint(x: graphWidth, y: 0), endPoint: CGPoint(x: graphWidth, y: cellHeight * 3))
                        .offset(y: cellHeight / 2)
                }

                HStack(alignment: .bottom,spacing: 0) {
                    // MARK: data는 hash를 요구하므로 0..<mockdata.count일때는 잘 동작하지 않음
                    ForEach(viewModel.records,id: \.self) { data in
                        VStack(spacing: 0) {
                            Text("\(data)")
                                .font(.system(size: 8, weight: .regular, design: .rounded))
                                .foregroundColor(.gray)
                                .isEmpty(logicalOperator: .and, [viewModel.selectedTimeUnit == .week])
                            Rectangle()
                                .fill(.green)
                                .frame(width: barWidth, height: cellHeight * 3.0 * Double(data) / Double(maxValue))
                                .cornerRadius(barCornerRadius,corners: [.topLeft,.topRight])
                        }
                        .padding(.horizontal,graphWidth / CGFloat(bottomLabels.count) / 2.0 - (barWidth / 2.0))
                        .offset(y: -cellHeight / 2)
                    }
                }
            }.frame(height: cellHeight * 4)

            HStack(spacing: 0) {
                ForEach(Array(bottomLabels.enumerated()),id: \.offset) { index, element in
                    Group {
                        switch viewModel.selectedTimeUnit {
                        case .week:
                            Text(element)
                                .font(.system(size: 10, weight: .regular, design: .rounded))
                                .frame(width: graphWidth / CGFloat(bottomLabels.count), alignment: .center)
                        case .month:
                            if (index + 1) % 3 == 0 {
                                Text(element)
                                    .font(.system(size: 6, weight: .regular, design: .rounded))
                                    .frame(width: graphWidth / CGFloat(bottomLabels.count), alignment: .center)
                            } else {
                                Text("")
                                    .font(.system(size: 10, weight: .regular, design: .rounded))
                                    .frame(width: graphWidth / CGFloat(bottomLabels.count), alignment: .center)
                            }
                        case .year:
                            Text(element)
                                .font(.system(size: 10, weight: .regular, design: .rounded))
                                .frame(width: graphWidth / CGFloat(bottomLabels.count), alignment: .center)
                        case .whole:
                            Text(element)
                                .font(.system(size: 10, weight: .regular, design: .rounded))
                                .frame(width: graphWidth / CGFloat(bottomLabels.count), alignment: .center)
                        }
                    }
                }
            }
            .frame(width: graphWidth)

            .offset(y: -cellHeight / 2)
        }
    }

}

extension Graph {
    @ViewBuilder
    func graphOuterLine(startPos: CGPoint,endPoint: CGPoint) -> some View {
        Path { path in
            path.move(to: startPos)
            path.addLine(to: endPoint)
        }
        .strokedPath(StrokeStyle(lineWidth: lineWidth))
        .foregroundColor(lineColor)
    }

    @ViewBuilder
    func lineWithText(text: String) -> some View {
        HStack {
            Rectangle()
                .frame(width: graphWidth, height: lineWidth)
                .foregroundColor(lineColor)
            Text(text)
                .font(.system(size: 10, weight: .regular, design: .rounded))
        }.frame(height: cellHeight)
    }
}

// MARK: - Graph_Previews
//
// struct Graph_Previews: PreviewProvider {
//    static var previews: some View {
//        Graph(graphWitdh: UIScreen.getWidthby(ratio: 0.7), cellHeight: UIScreen.getHeightby(ratio: 0.035), timeUnit: <#TimeUnit#>)
//    }
// }
