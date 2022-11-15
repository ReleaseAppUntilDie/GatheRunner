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
    
    let userDataRepository: UserRepository
    var cancelBag = Set<AnyCancellable>()
    
    init(userDataRepository: UserDataRepository = UserDataRepository()) {
        self.userDataRepository = userDataRepository
        bindCurrentUser()
    }
    
    func bindInfo(with user: FirebaseAuthResponseDTO) {
        isSignIn = true
        uid = user.uid
        email = user.email
    }
    
    private func bindCurrentUser() {
        userDataRepository.currentUser()
            .sink { [weak self] completion in
                switch completion {
                case .failure(_): self?.isSignIn = false
                    
                default: print("completion \(completion)")
                }
                
        } receiveValue: { [weak self] user in
            self?.bindInfo(with: user)
        }
        .store(in: &cancelBag)
    }
}
