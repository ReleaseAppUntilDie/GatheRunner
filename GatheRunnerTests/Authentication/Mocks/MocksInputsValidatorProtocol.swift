//
//  MocksInputsValidatorProtocol.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/09/29.
//

import Combine
@testable import GatheRunner

class MocksInputsValidatorProtocol: ObservableObject, InputsValidatorProtocol {

    // MARK: Lifecycle

    init() {
        bindValidation()
    }

    // MARK: Internal

    @Published var email = ""
    @Published var password = ""

    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    @Published var isInputsValid = false

    var cancelBag = Set<AnyCancellable>()


    func didValidation(testSample: String) {
        email = testSample
    }

    // MARK: Private


    private func bindValidation() {
        $email
            .compactMap { $0 }
            .sink { [weak self] in
                self?.isEmailValid = $0.isEmailValid
            }
            .store(in: &cancelBag)
    }
}
