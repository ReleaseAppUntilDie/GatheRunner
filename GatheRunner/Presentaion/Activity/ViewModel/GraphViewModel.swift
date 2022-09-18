//
//  GraphViewModel.swift
//  GatheRunner
//
//  Created by hanjaeseung on 2022/08/15.
//

import SwiftUI

class GraphViewModel: ObservableObject {

    // MARK: Lifecycle

    init() {
        pickerItemList = [String]()
        let periodString: ((Int,Int,Int,Int)) -> String = {
            "\($0.0).\($0.1)~\($0.2).\($0.3)"
        }
        let beforeTwoWeeks = beforeTwoWeeks()
        let beforeThreeWeeks = beforeThreeWeeks()

        pickerItemList = [
            "이번주",
            "저번주",
            periodString(beforeTwoWeeks),
            periodString(beforeThreeWeeks),
        ]
    }

    // MARK: Internal

    @Published var pickerItemList: [String]

    func updatePicker(timeUnit: TimeUnit) {
        switch timeUnit {
        case .week:
            let periodString: ((Int,Int,Int,Int)) -> String = {
                "\($0.0).\($0.1)~\($0.2).\($0.3)"
            }
            let beforeTwoWeeks = beforeTwoWeeks()
            let beforeThreeWeeks = beforeThreeWeeks()

            pickerItemList = [
                "이번주",
                "저번주",
                periodString(beforeTwoWeeks),
                periodString(beforeThreeWeeks),
            ]
        case .month:
            pickerItemList =
                [
                    "test",
                    "test",
                    "test",
                    "test",
                ]
        case .year:
            pickerItemList =
                [
                    "test",
                    "test",
                    "test",
                    "test",
                ]
        case .whole:
            break
        }
    }

    func beforeTwoWeeks() -> (firstDay: Int,firstMonth: Int,lastDay: Int,lastMonth: Int) {
        let date = Date()
        guard let weekDay = Calendar.current.dateComponents([.weekday], from: date).weekday else {
            return (0,0,0,0)
        }

        guard let beforeTwoWeeks = Calendar.current.date(byAdding: .day, value: -(14 + (weekDay - 2)), to: date) else {
            return (0,0,0,0)
        }
        guard let beforeOneWeek = Calendar.current.date(byAdding: .day, value: -(7 + (weekDay - 1)), to: date) else {
            return (0,0,0,0)
        }

        let firstDateAndMonth = Calendar.current.dateComponents([.month,.day], from: beforeTwoWeeks)
        let lastDateAndMonth = Calendar.current.dateComponents([.month,.day], from: beforeOneWeek)
        return (firstDateAndMonth.month ?? 0,firstDateAndMonth.day ?? 0,lastDateAndMonth.month ?? 0,lastDateAndMonth.day ?? 0)
    }

    func beforeThreeWeeks() -> (firstDay: Int,firstMonth: Int,lastDay: Int,lastMonth: Int) {
        let date = Date()
        guard let weekDay = Calendar.current.dateComponents([.weekday], from: date).weekday else {
            return (0,0,0,0)
        }

        guard let beforeTwoWeeks = Calendar.current.date(byAdding: .day, value: -(21 + (weekDay - 2)), to: date) else {
            return (0,0,0,0)
        }
        guard let beforeOneWeek = Calendar.current.date(byAdding: .day, value: -(14 + (weekDay - 1)), to: date) else {
            return (0,0,0,0)
        }

        let firstDateAndMonth = Calendar.current.dateComponents([.month,.day], from: beforeTwoWeeks)
        let lastDateAndMonth = Calendar.current.dateComponents([.month,.day], from: beforeOneWeek)
        return (firstDateAndMonth.month ?? 0,firstDateAndMonth.day ?? 0,lastDateAndMonth.month ?? 0,lastDateAndMonth.day ?? 0)
    }

    func isValidMonth(year: Int, month: Int) -> Bool {
        let dateComponents = DateComponents(year:year,month: month)
        let currentDate = Date()
        guard let willCompareDate = Calendar.current.date(from: dateComponents) else { return false }
        return currentDate >= willCompareDate
    }
}
