//
//  Authenticator.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/14.
//


import Combine

class Authenticator: ObservableObject {
    static var shared = Authenticator()
    
    @Published var isSignIn = false
    @Published var uid = ""
    @Published var email = ""
    
    var repo = FirebaseAuthUserRepository() //의존성 주입 및 다형성
    var cancelBag = Set<AnyCancellable>()
    
    init() {
        checkUser()
    }
    
    func bind(_ user: FirebaseAuthResponseDTO) {
        isSignIn = true
        uid = user.uid
        email = user.email
    }
    
    private func checkUser() {
        repo.currentUser()
            .sink { [weak self] completion in
                switch completion {
                case .failure(_): self?.isSignIn = false
                    
                default: print("completion \(completion)")
                }
                
        } receiveValue: { [weak self] user in
            self?.bind(user)
        }
        .store(in: &cancelBag)
    }
}
