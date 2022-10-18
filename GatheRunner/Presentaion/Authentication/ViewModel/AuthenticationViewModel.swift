//
//  AuthenticationViewModel.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/16.
//

import Combine

// MARK: - AuthenticationViewModel

final class AuthenticationViewModel: BaseInputsValidator {

    // MARK: Internal

    func signIn() {
        guard validatedInputs else { return }
    }

    func signUp() {
        guard validatedInputs else { return }
    }

    // MARK: Private

    private var validatedInputs: Bool {
        guard isEmailValid, isPasswordValid else {
            isInputsValid = false
            return isInputsValid
        }
        isInputsValid = true
        return isInputsValid
    }

}
