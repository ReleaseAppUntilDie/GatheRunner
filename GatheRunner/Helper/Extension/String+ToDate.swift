//
//  String+ToDate.swift
//  GatheRunner
//
//  Created by 모바일개발팀/한재승 on 2022/10/12.
//

import Foundation

extension String {
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter.date(from: self) ?? Date()
    }
    
    var toWeekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "EEEEEE"
        let convertStr = dateFormatter.string(from: self.toDate)
        return "\(convertStr)요일"
    }
}
