//
//  GraphViewModel.swift
//  GatheRunner
//
//  Created by hanjaeseung on 2022/08/15.
//

import Foundation
import Combine

class GraphViewModel: ObservableObject {

    // MARK: Internal

    @Published var pickerItemList = [String]()
    @Published var pickerItemListInMonth = ([Int](),[Int]())
    @Published var selectedString = "이번주"
    @Published var records = [100,200]
    @Published var response = [RunningRecordResponse]()

    var selectedTimeUnit: TimeUnit = .week
    var currentPeriod: (start: Date, end: Date) = (Date(),Date())
    
    let runningRecordRepository: RunningRecordRepository
    var cancelBag = Set<AnyCancellable>()

    // MARK: Lifecycle

    init(runningRecordRepository: RunningRecordRepository) {
        self.runningRecordRepository = runningRecordRepository
        dataInit()
        bindFetch()
    }

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
        
        guard let weekDay = date.get([.weekday]).weekday else {
            return (0,0,0,0)
        }

        let beforeTwoWeeks = date.calculatedDate(unit: .day, value: -(14 + (weekDay - 2)))
       
        let beforeOneWeek = date.calculatedDate(unit: .day, value: -(7 + (weekDay - 1)))
        
        let firstDateAndMonth = beforeTwoWeeks.get([.month, .day])
        
        let lastDateAndMonth = beforeOneWeek.get([.month, .day])
        
        return (firstDateAndMonth.month ?? 0,firstDateAndMonth.day ?? 0,lastDateAndMonth.month ?? 0,lastDateAndMonth.day ?? 0)
    }
    

    func beforeThreeWeeks() -> (firstDay: Int,firstMonth: Int,lastDay: Int,lastMonth: Int) {
        let date = Date()
        guard let weekDay = date.get([.weekday]).weekday else {
            return (0,0,0,0)
        }
        let beforeThreeWeeks = date.calculatedDate(unit: .day, value: -(21 + (weekDay - 2)))
        let beforeTwoWeek = date.calculatedDate(unit: .day, value: -(14 + (weekDay - 1)))
       
        let firstDateAndMonth = beforeThreeWeeks.get([.month, .day])
        let lastDateAndMonth = beforeTwoWeek.get([.month,.day])
        
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

    func bindFetch() {
        //uid 관리방법
        runningRecordRepository.fetch(RunningRecordRequest(uid: "hanTest"))
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else {return}
                switch completion {
                case .failure(let error):
                    print("debug error: ", error)
                case .finished:
                    print("fetch All data finished")
                }
            }, receiveValue: { [weak self] result in
                guard let self = self else {return}
                print("result \(result) count \(result.count)")
                self.response = result
            })
            .store(in: &cancelBag)
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
