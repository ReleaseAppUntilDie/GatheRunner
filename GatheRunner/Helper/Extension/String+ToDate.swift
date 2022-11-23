//
//  String+ToDate.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/23.
//

import Foundation

extension String {
    private var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter.date(from: self)
    }
    
    var toWeekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "EEEEEE"
        let convertStr = dateFormatter.string(from: self.toDate ?? Date())
        return "\(convertStr)요일"
    }
}
