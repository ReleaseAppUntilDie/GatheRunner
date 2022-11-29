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
    @Published var fetchStatus: FetchStatus = .none
        
    var cancelBag = Set<AnyCancellable>()
    var errorMessage = ""
    
    private let fetchStatusSubject = CurrentValueSubject<FetchStatus, Never>(.none)
    private let userRepository: UserRepository
    private let userManager: UserManager

    // MARK: Lifecycle
    
    init(userRepository: UserRepository, userManager: UserManager) {
        self.userRepository = userRepository
        self.userManager = userManager
        bindValidation()
        bindFetch()
    }
}

// MARK: Auth Methods

extension AuthenticationViewModel {
    func signIn() {
        fetchStatusSubject.send(.fetching)

        userRepository.signIn(AuthRequest(email: inputEmail, password: inputPassword))
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error): self?.bindError(error)
                default: return
                }

            } receiveValue: { [weak self] user in
                guard let self = self else { return }
                
                self.userManager.setInfo(with: user)
                self.fetchStatusSubject.send(.success)
            }
            .store(in: &cancelBag)
    }

    func signUp() {
        fetchStatusSubject.send(.fetching)

        userRepository.signUp(AuthRequest(email: inputEmail, password: inputPassword))
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error): self?.bindError(error)
                default: return

                }

            } receiveValue: { [weak self] user in
                guard let self = self else { return }

                self.userManager.setInfo(with: user)
                self.fetchStatusSubject.send(.success)

            }
            .store(in: &cancelBag)
    }

    func signOut() {
        fetchStatusSubject.send(.fetching)

        userRepository.signOut()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error): self?.bindError(error)
                default: return
                }

            } receiveValue: { [weak self] result in
                guard let self = self, result else { return }
                
                self.userManager.isSignIn = false
                self.fetchStatusSubject.send(.success)
            }
            .store(in: &cancelBag)
    }

    func deleteUser() {
        fetchStatusSubject.send(.fetching)
        
        userRepository.deleteUser()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.bindError(error)

                default: return
                }

            } receiveValue: { [weak self] result in
                guard let self = self, result else { return }

                self.userManager.isSignIn = false
                self.fetchStatusSubject.send(.success)
            }
            .store(in: &cancelBag)
    }
}

// MARK: Private Bind

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
    
    private func bindFetch() {
        fetchStatusSubject.assign(to: \.fetchStatus, on: self)
            .store(in: &cancelBag)
    }
    
    private func bindError(_ error: Error) {
        fetchStatusSubject.send(.failure)
        
        // MARK: Temp errorMessage

        errorMessage = error.localizedDescription
    }
}
