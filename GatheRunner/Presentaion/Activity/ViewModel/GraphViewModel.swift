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
        pickerListYear = [Int]()
        selectedString = "이번주"
        selectedTimeUnit = .week
        records = [Int]()

        dataInit()
        
        fetchAllData()
        
    }

    // MARK: Internal

    @Published var pickerItemList: [String]
    @Published var pickerItemListInMonth: ([Int],[Int])
    @Published var pickerListYear: [Int]
    @Published var selectedString: String
    @Published var records: [Int]
    @Published var historys: [History]?
    @Published var filteredHistorys: [History]? {
        didSet {
            if filteredHistorys != nil {
                self.drawGraph()
            }
        }
    }
    @Published var fetchError = false
    @Published var totalRecord: (distance: Int, count: Int, pace: String, totalTime: String)?
    var selectedTimeUnit: TimeUnit

    func updateTimeUnit(_ unit: TimeUnit) {
        selectedTimeUnit = unit
        switch unit {
        case .week:
            selectedString = "이번주"
            let index = pickerItemList.firstIndex(of: "이번주")
            getFilteredHistoryInWeek(index: index!)
        case .month:
            let current = Calendar.current.dateComponents([.year,.month], from: Date())
            selectedString = "\(String(current.year!))년 \(String(current.month!))월"
            getFilteredHistoryInMonth(year: current.year!, month: current.month!)
        case .year:
            let current = Calendar.current.dateComponents([.year], from: Date())
            selectedString = "\(String(current.year!))년"
            getFilteredHistoryInYear(year: current.year!)
        case .whole:
            selectedString = "전체"
            getFilteredHistoryInWhole()
        }
    }

    func updatePeriodText(selectedStr: String, selectedYear: Int,selectedMonth: Int) {
        switch selectedTimeUnit {
        case .week:
            selectedString = selectedStr
            let index = pickerItemList.firstIndex(of: selectedStr)
            getFilteredHistoryInWeek(index: index!)
        case .month:
            guard isValidMonth(year: selectedYear, month: selectedMonth) else { return }
            selectedString = "\(selectedYear)년 \(selectedMonth)월"
            getFilteredHistoryInMonth(year: selectedYear, month: selectedMonth)
        case .year:
            selectedString = "\(selectedYear)년"
            getFilteredHistoryInYear(year: selectedYear)
        default:
            break
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
            pickerListYear = calculateYears()
        case .whole:
            break
        }
    }

    private func beforeTwoWeeks() -> (firstDay: Int,firstMonth: Int,lastDay: Int,lastMonth: Int) {
        let date = Date()
        
        guard let weekDay = date.get([.weekday]).weekday else {
            return (0,0,0,0)
        }
        let constant = weekDay == 1 ? 7 : 0
        let beforeTwoWeeks = date.calculatedDate(unit: .day, value: -(constant + 14 + (weekDay - 2)))
       
        let beforeOneWeek = date.calculatedDate(unit: .day, value: -(constant + 7 + (weekDay - 1)))
        
        let firstDateAndMonth = beforeTwoWeeks.get([.month, .day])
        
        let lastDateAndMonth = beforeOneWeek.get([.month, .day])
        
        return (firstDateAndMonth.month ?? 0,firstDateAndMonth.day ?? 0,lastDateAndMonth.month ?? 0,lastDateAndMonth.day ?? 0)
    }
    
    private func getFilteredHistoryInWhole() {
        filteredHistorys = historys
        
        calculateTotalRecord()
        drawGraph()
    }
    
    private func getFilteredHistoryInYear(year: Int) {
        let today = Date()
        let dc = today.get([.year])
        if dc.year! == year {
            var comps = DateComponents()
            comps.day = 1
            comps.month = 1
            comps.year = year
            comps.hour = 0
            comps.minute = 0
            let firstDay = Calendar.current.date(from: comps)!
            filteredHistorys = historys?.filter { today.endOfday() >= $0.stringToDate && $0.stringToDate >= firstDay.startOfMonth().startOfDay() }
        } else {
            var comps = DateComponents()
            comps.day = 1
            comps.month = 1
            comps.year = year
            comps.hour = 0
            comps.minute = 0
            let firstDay = Calendar.current.date(from: comps)!
            comps.day = 31
            comps.month = 12
            comps.hour = 23
            comps.minute = 59
            let lastDay = Calendar.current.date(from: comps)!
            filteredHistorys = historys?.filter { lastDay.endOfday() >= $0.stringToDate && $0.stringToDate >= firstDay.startOfMonth().startOfDay() }
        }
        
        calculateTotalRecord()
        drawGraph()
    }
    private func getFilteredHistoryInMonth(year: Int, month: Int) {
        let today = Date()
        let dc = today.get([.year, .month])
        if dc.year! == year && dc.month! == month {
            filteredHistorys = historys?.filter { today.endOfday() >= $0.stringToDate && $0.stringToDate >= today.startOfMonth().startOfDay() }
        } else {
            var comps = DateComponents()
            comps.day = 2
            comps.month = month
            comps.year = year
            comps.hour = 0
            comps.minute = 0
            let date = Calendar.current.date(from: comps)!
            filteredHistorys = historys?.filter { date.endOfMonth().endOfday() >= $0.stringToDate && $0.stringToDate >= date.startOfMonth().startOfDay() }
        }
        
        calculateTotalRecord()
        drawGraph()
    }
    
    private func getFilteredHistoryInWeek(index: Int) {
        let today = Date().endOfday()
       
        guard let weekDay = today.get([.weekday]).weekday else { return }
        let constant = weekDay == 1 ? 7 : 0
        let monday = today.calculatedDate(unit: .day, value: -(7 * index + weekDay - 2 + constant)).startOfDay()
        let sunday = today.calculatedDate(unit: .day, value: -(7 * (index - 1) + weekDay - 1 + constant))

        if index == 0 {
            filteredHistorys = historys?.filter { today >= $0.stringToDate && $0.stringToDate >= monday }
        } else {
            filteredHistorys = historys?.filter { sunday >= $0.stringToDate && $0.stringToDate >= monday }
        }
        
        calculateTotalRecord()
        drawGraph()
    }
    
    private func calculateTotalRecord() {
        guard let historys = filteredHistorys, historys.count > 0 else {
            self.totalRecord = (distance: 0, count: 0, pace: "0'0''",totalTime: "0")
            return
        }
        var distance = 0
        var pacem = 0
        var paces = 0
        var totalTime = 0
        for hitory in historys  {
            distance += Int(hitory.distance!)!
            let curPacem = hitory.averagePace!.components(separatedBy: "'")[0]
            let curPaces = hitory.averagePace!.components(separatedBy: "'")[1].components(separatedBy: "'")[0]
            paces += Int(curPaces)!
            pacem += Int(curPacem)!
            var runningTimeArray = hitory.runningTime!.components(separatedBy: ":")
            var timeIndex = 1
            while !runningTimeArray.isEmpty {
                totalTime += Int(runningTimeArray.removeLast())! * timeIndex
                timeIndex *= 60
            }
        }
        pacem = pacem / historys.count
        paces += (pacem % historys.count) * 60
        paces = paces / historys.count
        if paces >= 60 {
            paces -= 60
            pacem += 1
        }
        
        self.totalRecord = (distance: distance, count: historys.count, pace: "\(pacem)'\(paces)''",totalTime: "\(totalTime.hours):\(totalTime.minutesWithHours):\(totalTime.seconds)")
    }
    
    func drawGraph() {
        guard let filteredHistorys = filteredHistorys else { return }

        switch selectedTimeUnit {
        case .week:
            var graphDates = [Int](repeating: 0, count: 7)
            filteredHistorys.forEach {
                let comps = $0.stringToDate.get([.weekday])
                var index = comps.weekday! - 2
                if index < 0 {
                    index = 6
                }
                graphDates[index] += Int($0.distance ?? "0") ?? 0
            }
            records = graphDates
        case .month:
            let lastDay = filteredHistorys.first?.stringToDate.endOfMonth().get([.day]).day!
            var graphDates = [Int](repeating: 0, count: lastDay ?? 0)
            filteredHistorys.forEach {
                let comps = $0.stringToDate.get([.day])
                let index = comps.day! - 1
               
                graphDates[index] += Int($0.distance ?? "0") ?? 0
            }
            records = graphDates
        case .year:
            var graphDates = [Int](repeating: 0, count: 12)
            filteredHistorys.forEach {
                let comps = $0.stringToDate.get([.month])
                let index = comps.month! - 1
                
                graphDates[index] += Int($0.distance ?? "0") ?? 0
            }
            records = graphDates
        case .whole:
            
            var graphDates = [Int](repeating: 0, count: 4)
            filteredHistorys.forEach {
                let comps = $0.stringToDate.get([.year])
                
                let index = comps.year! - (comps.year! - 4 + 1)
                
                graphDates[index] += Int($0.distance ?? "0") ?? 0
            }
           
            records = graphDates
        }
    }

    private func beforeThreeWeeks() -> (firstDay: Int,firstMonth: Int,lastDay: Int,lastMonth: Int) {
        let date = Date()
        guard let weekDay = date.get([.weekday]).weekday else {
            return (0,0,0,0)
        }
        let constant = weekDay == 1 ? 7 : 0
        let beforeThreeWeeks = date.calculatedDate(unit: .day, value: -(constant + 21 + (weekDay - 2)))
        let beforeTwoWeek = date.calculatedDate(unit: .day, value: -(constant + 14 + (weekDay - 1)))
       
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
                self.historys = result.sorted { $0.stringToDate > $1.stringToDate }
                self.getFilteredHistoryInWeek(index: 0)
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
