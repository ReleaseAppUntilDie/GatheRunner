//
//  String+ToRecordFormat.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/12/01.
//

import Foundation

extension String {
    private enum Format {
        static let period = "."
        static let apostrophe = "'"
        static let quotation = "''"
    }

    var toRecordFormat: String {
        var convertedFormat = self.replacingOccurrences(of: Format.period, with: Format.apostrophe)
        convertedFormat.append(Format.quotation)
        return convertedFormat
    }
}
