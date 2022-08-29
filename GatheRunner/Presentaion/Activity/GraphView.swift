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
        VStack(alignment:.leading) {
            TimeUnitsTable(curTimeUnit: $selectedTimeUnit)
                .padding(.bottom)
                .onTouch(type: .started) { point in
                    withAnimation {
                        setTimeUnitby(x: point.x)
                    }
                }
            // TODO: Picker 아이템 생성후 삽입
            SimplifiedStatistics(selectedTimeUnit: $selectedTimeUnit)

            Graph(graphWitdh: UIScreen.getWidthby(ratio: 0.7), cellHeight: UIScreen.getHeightby(ratio: 0.035))

        }.padding(.leading,UIScreen.getWidthby(ratio: 0.1))
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
            HStack(spacing: 40) {
                runningCount
                averagePace
                totalTime
            }
        }
    }

}

extension SimplifiedStatistics {
    var runningCount: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("6")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            Text("러닝")
                .foregroundColor(.gray)
                .font(.system(size: 12))
        }
    }

    var averagePace: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("5'41''")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            Text("평균 페이스")
                .foregroundColor(.gray)
                .font(.system(size: 12))
        }
    }

    var totalTime: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("2:54:51")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            Text("시간")
                .foregroundColor(.gray)
                .font(.system(size: 12))
        }
    }
}

// MARK: - Graph

struct Graph: View {

    let graphWitdh: CGFloat
    let cellHeight: CGFloat
    let lineWidth = 0.5
    let lingColor = Color(uiColor: .systemGray5)
    let bottomLabels = ["월","화","수","목","금","토","일","33"]
    var mockData = [10,2,3,4,5,5,7,11]

    var body: some View {
        VStack(alignment:.leading) {
            ZStack(alignment: .bottomLeading) {
                ZStack(alignment:.topLeading) {
                    lineWithText(text: "15")
                    lineWithText(text: "10")
                        .offset(y: cellHeight)
                    lineWithText(text: "5")
                        .offset(y: cellHeight * 2)
                    lineWithText(text: "0km")
                        .offset(y: cellHeight * 3)
                    graphOuterLine(startPos: CGPoint(x: graphWitdh, y: 0), endPoint: CGPoint(x: graphWitdh, y: cellHeight * 3))
                        .offset(y: cellHeight / 2)
                }

                HStack(alignment:.bottom,spacing: 0) {
                    ForEach(0..<bottomLabels.count) { index in
                        VStack(spacing:0) {
                            Text("\(mockData[index])")
                                .font(.system(size: 8, weight: .regular, design: .rounded))
                                .foregroundColor(.gray)
                            Rectangle()
                                .fill(.green)
                                .frame(width: 10, height: cellHeight * 3.0 * Double(mockData[index]) / 15.0)
                                .cornerRadius(3,corners: [.topLeft,.topRight])
                        }
                        .padding(.horizontal,graphWitdh / CGFloat(bottomLabels.count) / 2 - 5)
                        .offset(y: -cellHeight / 2)
                    }
                }


            }.frame(height: cellHeight * 4)

            HStack(spacing:0) {
                ForEach(bottomLabels,id:\.self) {
                    Text($0)
                        .font(.system(size: 10, weight: .regular, design: .rounded))
                        .frame(width: graphWitdh/CGFloat(bottomLabels.count), alignment: .center)
                }
            }
            .frame(width: graphWitdh)

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
        .foregroundColor(lingColor)
    }

    @ViewBuilder
    func lineWithText(text: String) -> some View {
        HStack {
            Rectangle()
                .frame(width: graphWitdh, height: lineWidth)
                .foregroundColor(lingColor)
            Text(text)
                .font(.system(size: 10, weight: .regular, design: .rounded))
        }.frame(height:cellHeight)
    }
}

// MARK: - GraphView_Previews

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}

