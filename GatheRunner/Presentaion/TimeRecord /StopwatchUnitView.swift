//
//  StopwatchUnitView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/17.
//

import SwiftUI

// MARK: - StopwatchUnit

struct StopwatchUnit: View {

    var timeUnit: Int

    var timeUnitStr: String {
        let timeUnitStr = String(timeUnit)
        return timeUnit < 10 ? "0" + timeUnitStr : timeUnitStr
    }

    var body: some View {
        VStack {
            ZStack {
                HStack(spacing: 2) {
                    Text(timeUnitStr.substring(index: 0))
                        .font(.system(size: 48))
                        .frame(width: 28)
                    Text(timeUnitStr.substring(index: 1))
                        .font(.system(size: 48))
                        .frame(width: 28)
                }
            }
        }
        .foregroundColor(.white)
    }
}

// MARK: - Stopwatch_Previews

struct Stopwatch_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            TimeRecord()
        }
    }
}

extension String {
    func substring(index: Int) -> String {
        let arrayString = Array(self)
        return String(arrayString[index])
    }
}
