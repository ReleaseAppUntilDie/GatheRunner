//
//  AuthViewModel.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/27.
//

import Combine

// MARK: - AuthenticationViewModel

final class AuthenticationViewModel: ObservableObject {

    // MARK: Lifecycle

    init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
        self.authService = authService
    }

    // MARK: Internal

    @Published var email = ""
    @Published var password = ""
    @Published var isValid = false
    @Published var errorMessage: String?
    @Published var token: String?

    var cancelBag = Set<AnyCancellable>()

    func loginUser() {
        authService.signIn(withEmail: email, password: password)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.isValid = false
                    self?.errorMessage = String("\(error)")

                case .finished: break
                }
            } receiveValue: { [weak self] token in
                self?.token = token
                self?.isValid = true
            }
            .store(in: &cancelBag)
    }

    func createUser() {
        authService.signUp(withEmail: email, password: password)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.isValid = false
                    self?.errorMessage = String("\(error)")

                case .finished: break
                }
            } receiveValue: { [weak self] token in
                self?.token = token
                self?.isValid = true
            }
            .store(in: &cancelBag)
    }

    // MARK: Private

    private let authService: AuthenticationServiceProtocol
}
