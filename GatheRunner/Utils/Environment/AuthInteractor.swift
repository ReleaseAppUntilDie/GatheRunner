//
//  AuthInteractor.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/14.
//

import Combine

class AuthInteractor: ObservableObject {
    @Published var isSignIn = false
    @Published var uid = ""
    @Published var email = ""
    
    let userRepository: UserRepository
    var cancelBag = Set<AnyCancellable>()
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        bindCurrentUser()
    }
    
    func setInfo(with user: AuthResponse) {
        isSignIn = true
        uid = user.uid
        email = user.email
    }
    
    private func bindCurrentUser() {
        userRepository.currentUser()
            .sink { [weak self] completion in
                switch completion {
                case .failure(_): self?.isSignIn = false
                    
                default: print("completion \(completion)")
                }
                
            } receiveValue: { [weak self] user in
                self?.setInfo(with: user)
            }
            .store(in: &cancelBag)
    }
}
