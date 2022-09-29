//
//  InputsValidatorProtocol.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/29.
//

protocol InputsValidatorProtocol {
    var email: String { get set }
    var password: String { get set }

    var isEmailValid: Bool { get set }
    var isPasswordValid: Bool { get set }
    var isInputsValid: Bool { get set }
}
