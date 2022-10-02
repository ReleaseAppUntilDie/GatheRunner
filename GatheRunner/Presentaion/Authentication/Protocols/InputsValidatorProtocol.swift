//
//  InputsValidatorProtocol.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/29.
//

import Combine

// MARK: - InputsValidatorProtocol

protocol InputsValidatorProtocol {
    var email: String { get set }
    var password: String { get set }

    var isEmailValid: Bool { get set }
    var isPasswordValid: Bool { get set }
    var isInputsValid: Bool { get set }
}

// MARK: - BaseInputsValidator

public class BaseInputsValidator: ObservableObject, InputsValidatorProtocol {

    // MARK: Lifecycle

    init() {
        bindValidation()
    }

    // MARK: Public

    @Published public var isAuthValid = false
    @Published public var isEmailValid = false
    @Published public var isPasswordValid = false
    @Published public var isInputsValid = false

    public var cancelBag = Set<AnyCancellable>()

    // MARK: Internal

    @Published var email = ""
    @Published var password = ""

    // MARK: Private

    private func bindValidation() {
        $email
            .compactMap { $0 }
            .sink { [weak self] in
                self?.isEmailValid = $0.isEmailValid
            }
            .store(in: &cancelBag)

        $password
            .compactMap { $0 }
            .sink { [weak self] in
                self?.isPasswordValid = $0.isPasswordValid
            }
            .store(in: &cancelBag)
    }
}
