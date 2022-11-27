//
//  UserManager.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/26.
//
import Combine

class UserManager: ObservableObject {
    @Published var uid = ""
    @Published var userEmail = ""
    @Published var isSignIn = false

    private let userRepository: UserRepository
    private var cancelBag = Set<AnyCancellable>()

    // MARK: Lifecycle
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        bindCurrentUser()
    }

    func setInfo(with user: AuthResponse) {
        isSignIn = true
        uid = user.uid
        userEmail = user.email
    }

    private func bindCurrentUser() {
        userRepository.currentUser()
            .sink { completion in
                switch completion {
                case .failure(let error): print("error \(error)")
                default: print("completion \(completion)")
                }

            } receiveValue: { [weak self] user in
                self?.setInfo(with: user)
            }
            .store(in: &cancelBag)
    }
}
