//
//  MocksInputsValidator.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/09/29.
//

@testable import GatheRunner

class MocksInputsValidator: BaseInputsValidator {
    func didValidation(isTestWithEmail: Bool, by exampe: String) {
        if isTestWithEmail {
            email = exampe
        } else {
            password = exampe
        }
    }
}
