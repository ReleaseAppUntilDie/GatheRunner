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

    var cancelBag = Set<AnyCancellable>()

    // MARK: Temp - SubScribeMethods

    func loginUser() {
        isAuthValid = true
    }

    func createUser() {
        isAuthValid = true
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
}
