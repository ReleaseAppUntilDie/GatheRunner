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
    
    //옵셔널?
    @Published var uid: String?
    @Published var email: String?
    
    //의존성 주입 및 다형성
    var repo = FirebaseAuthUserRepository()
    var cancelBag = Set<AnyCancellable>()
    
    init() {
        checkUser()
    }
    
    private func checkUser() {
        repo.currentUser().sink { [weak self] _ in
//            self?.isSignIn = false
        } receiveValue: { [weak self] user in
            self?.isSignIn = true
            self?.uid = user.uid
            self?.email = user.email
        }
        .store(in: &cancelBag)
    }
    
}
