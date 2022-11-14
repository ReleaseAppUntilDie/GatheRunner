//
//  FirebaseAPIManager+Auth.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/25.
//

import Combine
import FirebaseAuth

extension FirebaseAPIManager {
    
    // MARK: Internal
    
    func signIn(withEmail email: String?, password: String?) -> AnyPublisher<AuthResponseDTO, Error> {
        Future<AuthResponseDTO, Error> { [weak self] promise in
            guard let email = email, let password = password else { return }
            self?.auth.signIn(withEmail: email, password: password) { auth, error in
                if let error = error {
                    promise(.failure(error))
                } else if let auth = auth {
                    promise(.success(AuthResponseDTO(auth.user)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signIn(withEmail email: String?, link: String?) -> AnyPublisher<AuthResponseDTO, Error> {
        Future<AuthResponseDTO, Error> { [weak self] promise in
            guard let email = email, let link = link else { return }
            self?.auth.signIn(withEmail: email, link: link) { auth, error in
                if let error = error {
                    promise(.failure(error))
                } else if let auth = auth {
                    promise(.success(AuthResponseDTO(auth.user)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signIn(with credential: AuthCredential?) -> AnyPublisher<AuthResponseDTO, Error> {
        Future<AuthResponseDTO, Error> { [weak self] promise in
            guard let credential = credential else { return }
            self?.auth.signIn(with: credential) { auth, error in
                if let error = error {
                    promise(.failure(error))
                } else if let auth = auth {
                    promise(.success(AuthResponseDTO(auth.user)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signInAnonymously() -> AnyPublisher<AuthResponseDTO, Error> {
        Future<AuthResponseDTO, Error> { [weak self] promise in
            self?.auth.signInAnonymously { auth, error in
                if let error = error {
                    promise(.failure(error))
                } else if let auth = auth {
                    promise(.success(AuthResponseDTO(auth.user)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signIn(withCustomToken token: String?) -> AnyPublisher<AuthResponseDTO, Error> {
        Future<AuthResponseDTO, Error> { [weak self] promise in
            guard let token = token else { return }
            self?.auth.signIn(withCustomToken: token) { auth, error in
                if let error = error {
                    promise(.failure(error))
                } else if let auth = auth {
                    promise(.success(AuthResponseDTO(auth.user)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func createUser(withEmail email: String?, password: String?) -> AnyPublisher<AuthResponseDTO, Error> {
        Future<AuthResponseDTO, Error> { [weak self] promise in
            guard let email = email, let password = password else { return }
            self?.auth.createUser(withEmail: email, password: password) { auth, error in
                if let error = error {
                    promise(.failure(error))
                } else if let auth = auth {
                    promise(.success(AuthResponseDTO(auth.user)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteUser() -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { [weak self] promise in
            self?.auth.currentUser?.delete { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(true))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signOut() -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { [weak self] promise in
            do {
                try self?.auth.signOut()
                promise(.success(true))
            } catch let error {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func currentUser() -> AnyPublisher<AuthResponseDTO, Error> {
        Future<AuthResponseDTO, Error> { [weak self] promise in
            guard let user = self?.auth.currentUser else {
                return
            }
            promise(.success(AuthResponseDTO(user)))
        }.eraseToAnyPublisher()
    }
    
    // MARK: Private
    
    private var auth: Auth {
        Auth.auth()
    }
}
