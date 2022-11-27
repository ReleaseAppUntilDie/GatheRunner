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
    
    static var currentDate: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
    
        return formatter.string(from: Date())
    }
}
