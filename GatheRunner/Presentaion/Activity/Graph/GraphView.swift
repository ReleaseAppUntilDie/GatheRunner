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
            PeriodView(curTimeUnit: $selectedTimeUnit)
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

// MARK: - GraphView_Previews

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
