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
    @Published var isNotEmailValid = false
    @Published var isNotPasswordValid = false

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
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .compactMap { $0 }
            .sink { [weak self] in
                self?.isNotEmailValid = !$0.isValidEmail
            }
            .store(in: &cancelBag)

        $password
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .compactMap { $0 }
            .sink { [weak self] in
                self?.isNotPasswordValid = !$0.isValidPassword
            }
            .store(in: &cancelBag)
    }

}
