//
//  MocksInputsValidator.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/09/29.
//

@testable import GatheRunner

class MocksInputsValidator: BaseInputsValidator {
    enum InputType {
        case email
        case password
    }


    func inputTestSample(_ inputType: InputType, with example: String) {
        switch inputType {
        case .email: email = example
        case .password: password = example
        }
    }
}
