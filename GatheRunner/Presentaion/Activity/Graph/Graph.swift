//
//  Graph.swift
//  GatheRunner
//
//  Created by 김현진 on 2022/09/06.
//

import SwiftUI


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
                        .frame(width: graphWitdh / CGFloat(bottomLabels.count), alignment: .center)
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

// MARK: - Graph_Previews

struct Graph_Previews: PreviewProvider {
    static var previews: some View {
        Graph(graphWitdh: UIScreen.getWidthby(ratio: 0.7), cellHeight: UIScreen.getHeightby(ratio: 0.035))
    }
}
