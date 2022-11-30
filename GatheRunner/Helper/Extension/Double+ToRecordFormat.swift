//
//  Double+ToRecordFormat.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/12/01.
//

import Foundation

extension Double {
    private enum Format {
        static let period = "."
        static let apostrophe = "'"
        static let quotation = "''"
    }

    var toRecordFormat: String {
        var convertedFormat = String(self).replacingOccurrences(of: Format.period, with: Format.apostrophe, options: .regularExpression)
        convertedFormat.append(Format.quotation)
        return convertedFormat
    }
}
