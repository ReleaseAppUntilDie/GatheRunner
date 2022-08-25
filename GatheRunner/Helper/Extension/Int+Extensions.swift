//
//  Int+Extensions.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/17.
//

extension Int {

    var minutes: String {
        (self / 60).timeUnit
    }

    var seconds: String {
        (self % 60).timeUnit
    }

    var timeUnit: String {
        self < 10 ? "0" + String(self) : String(self)
    }
}
