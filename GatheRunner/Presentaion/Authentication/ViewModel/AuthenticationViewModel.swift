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
    //의존성 주입 및 다형성
    let repo: FirebaseAuthUserRepository = FirebaseAuthUserRepository()

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
        guard validatedInputs() else { return }
//        let request = FirebaseAuthRequestDTO(option: .password, email: email, password: password)
//        repo.signIn(request: request)
//            .sink { _ in
//            } receiveValue: { [weak self] user in
//                self?.authenticator.isSignIn = true
//                self?.authenticator.uid = user.uid
//                self?.authenticator.email = user.email
//            }
//            .store(in: &cancelBag)
    }

    func signUp(authenticator: Authenticator) {
        guard validatedInputs() else { return }
        let request = FirebaseAuthRequestDTO(email: email, password: password)
        repo.signUp(request: request)
            .sink { _ in
            } receiveValue: { [weak self] user in
                self?.isAuthValid = true
                authenticator.uid = user.uid
                authenticator.email = user.email
            }
            .store(in: &cancelBag)
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

    private func validatedInputs() -> Bool {
        guard isEmailValid, isPasswordValid else {
            isInputsValid = false
            return isInputsValid
        }
        isInputsValid = true
        return isInputsValid
    }

}
