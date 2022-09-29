//
//  String+isValid.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/16.
//

import Foundation

extension String {

    var isEmailValid: Bool {
        let name = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let domain = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailRegEx = name + "@" + domain + "[A-Za-z]{2,8}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }

    var isPasswordValid: Bool {
        let passwordreg = "(?=.*[A-Za-z])(?=.*[0-9]).{8,20}"
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: self)
    }
}
