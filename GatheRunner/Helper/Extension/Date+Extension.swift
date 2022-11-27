//
//  Date+Extension.swift
//  GatheRunner
//
//  Created by 김현미 on 2022/11/22.
//

import Foundation

extension Date {
    private enum Format {
        static let longTypeDateAndShortTypeTime = "yyyy/MM/dd HH:mm"
    }
    
    func get(_ components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    }
    
    func calculatedDate(unit: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: unit, value: value, to: self) ?? self
    }
    
    static var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = Format.longTypeDateAndShortTypeTime
        return formatter.string(from: Date())
    }
}
