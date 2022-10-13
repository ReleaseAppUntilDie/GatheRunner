//
//  PeriodView.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/09/06.
//

import SwiftUI

// MARK: - PeriodView

struct PeriodView: View {

    @Binding var curTimeUnit: TimeUnit
    let data = [("주",TimeUnit.week),("월",TimeUnit.month),("년",TimeUnit.year),("전체",TimeUnit.whole)]

    var unitIndex: Double {
        switch curTimeUnit {
        case .week: return 0
        case .month: return 1
        case .year: return 2
        case .whole: return 3
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
                HStack(spacing: 0) {
                    ForEach(0..<4) { index in
                        Text(data[index].0)
                            .foregroundColor(curTimeUnit == data[index].1 ? .black : .init(uiColor: .systemGray2))
                            .frame(width: UIScreen.getWidthby(ratio: 0.2))
                    }
                }
            }
        }
    }
}

// MARK: - PeriodView_Previews

struct PeriodView_Previews: PreviewProvider {
    static var previews: some View {
        PeriodView(curTimeUnit: .constant(.week))
    }
}
