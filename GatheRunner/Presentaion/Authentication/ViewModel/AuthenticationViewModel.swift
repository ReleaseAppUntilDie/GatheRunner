//
//  AuthenticationViewModel.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/16.
//

import Combine
import Foundation

// MARK: - AuthenticationViewModel

final class AuthenticationViewModel: ObservableObject {

    // MARK: Lifecycle

    init() {
        bindValidation()
    }

    // MARK: Internal

    @Published var email = ""
    @Published var password = ""
    @Published var isAuthValid = false
    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    @Published var isInputsValid = false

    var cancelBag = Set<AnyCancellable>()


    // MARK: Temp - NoService

    func signIn() {
        guard didValidate() else { return }
    }

    func signUp() {
        guard didValidate() else { return }
    }

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

    private func didValidate() -> Bool {
        guard isEmailValid, isPasswordValid else {
            isInputsValid = false
            return false
        }
        isInputsValid = true
        return true
    }
}
