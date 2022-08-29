//
//  AuthViewModel.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/27.
//

import Combine

class AuthenticationViewModel: ObservableObject {

    // MARK: Lifecycle


    init() { }

    // MARK: Internal

    @Published var email = ""
    @Published var password = ""
    @Published var isAuth: Bool?

    var cancelBag = Set<AnyCancellable>()


    func loginUser() {
        AuthenticationService.signIn(withEmail: email, password: password)
            .sink { completion in
                switch completion {
                case .failure(let error): print(error)
                case .finished: break
                }
            } receiveValue: { [weak self] data in
                self?.isAuth = true
            }
            .store(in: &cancelBag)
    }

    func createUser() {
        AuthenticationService.createUser(withEmail: email, password: password)
            .sink { completion in
                switch completion {
                case .failure(let error): print(error)
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                self?.isAuth = true
            }
            .store(in: &cancelBag)
    }
}
