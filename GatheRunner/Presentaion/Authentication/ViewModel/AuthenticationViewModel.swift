//
//  AuthenticationViewModel.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/16.
//

import Combine

final class AuthenticationViewModel: ObservableObject {

    // MARK: Internal
    
    @Published var inputEmail = ""
    @Published var inputPassword = ""
    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    @Published var isInputsValid = false
    @Published var isAuthValid = false

    var cancelBag = Set<AnyCancellable>()

    private let userRepository: UserRepository
    private let userManager: UserManager

    // MARK: Lifecycle
    
    init(userRepository: UserRepository, userManager: UserManager) {
        self.userRepository = userRepository
        self.userManager = userManager

        bindValidation()
    }
}

// MARK: Internal Methods

extension AuthenticationViewModel {
    func signIn() {
        guard validatedInputs() else { return }

        userRepository.signIn(AuthRequest(email: inputEmail, password: inputPassword))
            .sink { [weak self] completion in
                switch completion {
                case .failure(_): self?.isAuthValid = false

                default: print("completion \(completion)")
                }

            } receiveValue: { [weak self] user in
                self?.userManager.setInfo(with: user)
            }
            .store(in: &cancelBag)
    }

    func signUp() {
        guard validatedInputs() else { return }

        userRepository.signUp(AuthRequest(email: inputEmail, password: inputPassword))
            .sink { [weak self] completion in
                switch completion {
                case .failure(_): self?.isAuthValid = false

                default: print("completion \(completion)")
                }

            } receiveValue: { [weak self] user in
                self?.userManager.setInfo(with: user)
            }
            .store(in: &cancelBag)
    }

    func signOut() {
        userRepository.signOut()
            .sink { completion in
                switch completion {
                case .failure(let error): print("error \(error)")
                default: print("completion \(completion)")
                }

            } receiveValue: { [weak self] _ in
                self?.userManager.isSignIn = false
            }
            .store(in: &cancelBag)
    }

    func deleteUser() {
        userRepository.deleteUser()
            .sink { completion in
                switch completion {
                case .failure(let error): print("error \(error)")
                default: print("completion \(completion)")
                }

            } receiveValue: { [weak self] _ in
                self?.userManager.isSignIn = false
            }
            .store(in: &cancelBag)
    }
}

// MARK: Private Methods

extension AuthenticationViewModel {
    private func bindValidation() {
        $inputEmail
            .compactMap { $0 }
            .sink { [weak self] in
                self?.isEmailValid = $0.isEmailValid
            }
            .store(in: &cancelBag)

        $inputPassword
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
