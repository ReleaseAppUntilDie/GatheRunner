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
    var cancelBag = Set<AnyCancellable>()
    
    // MARK: Lifecycle
    
    init(userRepository: UserRepository) { 
        self.userRepository = userRepository
        bindValidation()
    }
    
    func signIn(authenticator: Authenticator) {
        guard validatedInputs() else { return }
        
        userRepository.signIn(AuthRequest(email: email, password: password))
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.isAuthValid = false
                    authenticator.isSignIn = false
                    
                default: print("completion \(completion)")
                }
                
            } receiveValue: { [weak self] user in
                self?.isAuthValid = true
                authenticator.setInfo(with: user)
            }
            .store(in: &cancelBag)
    }
    
    func signUp(authenticator: Authenticator) {
        guard validatedInputs() else { return }
        
        userRepository.signUp(AuthRequest(email: email, password: password))
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.isAuthValid = false
                    authenticator.isSignIn = false
                    
                default: print("completion \(completion)")
                }
                
            } receiveValue: { [weak self] user in
                self?.isAuthValid = true
                authenticator.setInfo(with: user)
            }
            .store(in: &cancelBag)
    }
    
    func signOut(authenticator: Authenticator) {
        userRepository.signOut()
            .sink { completion in
                switch completion {
                case .failure(let error): print("error \(error)")
                default: print("completion \(completion)")
                }
                
            } receiveValue: { result in
                guard result else { return }
                authenticator.isSignIn = false
            }
            .store(in: &cancelBag)
    }
    
    func deleteUser(authenticator: Authenticator) {
        userRepository.deleteUser()
            .sink { completion in
                switch completion {
                case .failure(let error): print("error \(error)")
                default: print("completion \(completion)")
                }
                
            } receiveValue: { result in
                guard result else { return }
                authenticator.isSignIn = false
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
