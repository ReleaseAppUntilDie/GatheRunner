//
//  GraphViewModel.swift
//  GatheRunner
//
//  Created by hanjaeseung on 2022/08/15.
//

import SwiftUI

class GraphViewModel: ObservableObject {

    @Published var pickerItemList = [String]()

    func updatePicker(timeUnit: TimeUnit) {
        switch timeUnit {
        case .week:
            let beforeTwoWeeks = beforeTwoWeeks()
            let beforeThreeWeeks = beforeThreeWeeks()
            pickerItemList = [
                "이번주",
                "저번주",
                "\(beforeTwoWeeks.firstMonth ?? 0)",
            ]
        case .month:
            break
        case .year:
            break
        case .whole:
            break
        }
    }

    func beforeTwoWeeks() -> (firstDay: Int?,firstMonth: Int?,lastDay: Int?,lastMonth: Int?) {
        let date = Date()
        guard let weekDay = Calendar.current.dateComponents([.weekday], from: date).weekday else {
            return (nil,nil,nil,nil)
        }

        guard let beforeTwoWeeks = Calendar.current.date(byAdding: .day, value: -(14 + (weekDay - 2)), to: date) else {
            return (nil,nil,nil,nil)
        }
        guard let beforeOneWeek = Calendar.current.date(byAdding: .day, value: -(7 + (weekDay - 1)), to: date) else {
            return (nil,nil,nil,nil)
        }

        let firstDateAndMonth = Calendar.current.dateComponents([.month,.day], from: beforeTwoWeeks)
        let lastDateAndMonth = Calendar.current.dateComponents([.month,.day], from: beforeOneWeek)
        return (firstDateAndMonth.day,firstDateAndMonth.month,lastDateAndMonth.day,lastDateAndMonth.month)
    }

    func beforeThreeWeeks() -> (firstDay: Int?,firstMonth: Int?,lastDay: Int?,lastMonth: Int?) {
        let date = Date()
        guard let weekDay = Calendar.current.dateComponents([.weekday], from: date).weekday else {
            return (nil,nil,nil,nil)
        }

        guard let beforeTwoWeeks = Calendar.current.date(byAdding: .day, value: -(21 + (weekDay - 2)), to: date) else {
            return (nil,nil,nil,nil)
        }
        guard let beforeOneWeek = Calendar.current.date(byAdding: .day, value: -(14 + (weekDay - 1)), to: date) else {
            return (nil,nil,nil,nil)
        }

        let firstDateAndMonth = Calendar.current.dateComponents([.month,.day], from: beforeTwoWeeks)
        let lastDateAndMonth = Calendar.current.dateComponents([.month,.day], from: beforeOneWeek)
        return (firstDateAndMonth.day,firstDateAndMonth.month,lastDateAndMonth.day,lastDateAndMonth.month)
    }

    func isValidMonth(year: Int, month: Int) -> Bool {
        let dateComponents = DateComponents(year:year,month: month)
        let currentDate = Date()
        guard let willCompareDate = Calendar.current.date(from: dateComponents) else { return false }
        return currentDate >= willCompareDate
    }
}
