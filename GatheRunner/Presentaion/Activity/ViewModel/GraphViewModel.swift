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
        pickerItemListInMonth = ([Int](),[Int]())
        selectedString = "이번주"
        selectedTimeUnit = .week
        records = [Int]()

        dataInit()

        fetchData()
        
        fetchAllData()
    }

    // MARK: Internal

    @Published var pickerItemList: [String]
    @Published var pickerItemListInMonth: ([Int],[Int])
    @Published var selectedString: String
    @Published var records: [Int]
    @Published var historys: [History] = []
    @Published var fetchError = false
    var selectedTimeUnit: TimeUnit

    func updateTimeUnit(_ unit: TimeUnit) {
        selectedTimeUnit = unit
        switch unit {
        case .week:
            selectedString = "이번주"
        case .month:
            let current = Calendar.current.dateComponents([.year,.month], from: Date())
            selectedString = "\(String(current.year!))년 \(String(current.month!))월"
        case .year:
            let current = Calendar.current.dateComponents([.year], from: Date())
            selectedString = "\(String(current.year!))년"
        case .whole:
            selectedString = "전체"
        }
    }

    func updateSelected(selectedStr: String, selectedYear: Int,selectedMonth: Int) {
        switch selectedTimeUnit {
        case .week, .whole:
            selectedString = selectedStr
        case .month:
            guard isValidMonth(year: selectedYear, month: selectedMonth) else { return }
            selectedString = "\(selectedYear)년 \(selectedMonth)월"
        case .year:
            selectedString = "\(selectedYear)년"
        }
     
    }

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
            let years = calculateYears()
            var result = ([Int](),[Int]())

            result.0 = years
            result.1 = Array(1...12)
            pickerItemListInMonth = result

        case .year:

            pickerItemList = calculateYears().map {
                "\($0)년"
            }
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

    func calculateYears() -> [Int] {
        var result = [Int]()
        let current = Calendar.current.dateComponents([.year], from: Date())
        for i in 0..<4 {
            result.append(current.year! - i)
        }
        return result
    }

    func isValidMonth(year: Int, month: Int) -> Bool {
        let dateComponents = DateComponents(year: year,month: month)
        let currentDate = Date()
        guard let willCompareDate = Calendar.current.date(from: dateComponents) else { return false }
        return currentDate >= willCompareDate
    }

    func fetchData() {
        
        switch selectedTimeUnit {
        case .week:
            records = (0..<7).map { _ in Int.random(in: 1 ... 20) }
        case .month:
            records = (0..<30).map { _ in Int.random(in: 1 ... 20) }
        case .year:
            records = (0..<12).map { _ in Int.random(in: 1 ... 20) }
        case .whole:
            records = (0..<4).map { _ in Int.random(in: 1 ... 20) }
        }
    }
    
    func fetchAllData() {
        RunningRecordAPIs.fetchRunningRecord(request: RunningRecordRequest(uid: "hanTest"))
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else {return}
                switch completion {
                case .failure(let error):
                    print("debug error: ", error)
                    self.fetchError = true
                case .finished:
                    print("fetch All data finished")
                }
            }, receiveValue: { [weak self] result in
                guard let self = self else {return}
                self.historys = result
            })
            .store(in: &RunningRecordAPIs.cancelBag)
    }

    // MARK: Private

    private func dataInit() {
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

}
