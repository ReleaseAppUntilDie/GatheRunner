//
//  Date+Extension.swift
//  GatheRunner
//
//  Created by 김현미 on 2022/11/22.
//

import Foundation

extension Date {
    func get(_ components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    }
    
    func calculatedDate(unit: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: unit, value: value, to: self) ?? self
    }
    
    func endOfday() -> Date {
        let date = self.get([.day, .month, .year])
        var comps = DateComponents()
        comps.day = date.day ?? 0
        comps.month = date.month ?? 0
        comps.year = date.year ?? 0
        comps.hour = 23
        comps.minute = 59
        return Calendar.current.date(from: comps) ?? Date()
    }
    
    func startOfDay() -> Date {
        let date = self.get([.day, .month, .year])
        var comps = DateComponents()
        comps.day = date.day ?? 0
        comps.month = date.month ?? 0
        comps.year = date.year ?? 0
        comps.hour = 0
        comps.minute = 0
        return Calendar.current.date(from: comps) ?? Date()
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self))) ?? Date()
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()) ?? Date()
    }
}
