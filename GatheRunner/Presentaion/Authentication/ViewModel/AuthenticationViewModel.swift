//
//  AuthenticationViewModel.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/16.
//

import Combine

// MARK: - AuthenticationViewModel

final class AuthenticationViewModel: ObservableObject {
    
    // MARK: Internal
    
    @Published var email = ""
    @Published var password = ""
    @Published var isAuthValid = false
    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    @Published var isInputsValid = false
    
    let userRepository: UserRepository
    let authInteractor: AuthInteractor
    var cancelBag = Set<AnyCancellable>()
    
    // MARK: Lifecycle
    
    init(userRepository: UserRepository, authInteractor: AuthInteractor) {
        self.userRepository = userRepository
        self.authInteractor = authInteractor
        bindValidation()
    }
    
    func signIn() {
        guard validatedInputs() else { return }
        
        userRepository.signIn(AuthRequest(email: email, password: password))
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.isAuthValid = false
                    self?.authInteractor.isSignIn = false
                    
                default: print("completion \(completion)")
                }
                
            } receiveValue: { [weak self] user in
                self?.isAuthValid = true
                self?.authInteractor.setInfo(with: user)
            }
            .store(in: &cancelBag)
    }
    
    func signUp() {
        guard validatedInputs() else { return }
        
        userRepository.signUp(AuthRequest(email: email, password: password))
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.isAuthValid = false
                    self?.authInteractor.isSignIn = false
                    
                default: print("completion \(completion)")
                }
                
            } receiveValue: { [weak self] user in
                self?.isAuthValid = true
                self?.authInteractor.setInfo(with: user)
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
                
            } receiveValue: { [weak self] result in
                guard result else { return }
                self?.authInteractor.isSignIn = false
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
                
            } receiveValue: { [weak self] result in
                guard result else { return }
                self?.authInteractor.isSignIn = false
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
