//
//  FirebaseAPIManager+Auth.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/25.
//

import FirebaseAuth
import Combine

class FirebaseAPIManager {
    static let shared: FirebaseAPIManager = FirebaseAPIManager()

    let auth = Auth.auth()
    enum Option {
        case password
        case link
        case credential
        case anonymously
        case customToken
    }
    
    func signIn(withEmail email: String, password: String) -> AnyPublisher<AuthResponseDTO, NetworkError> {
        Future<AuthResponseDTO, NetworkError> { [weak self] promise in
            self?.auth.signIn(withEmail: email, password: password) { auth, error in
                if let error = error {
                    let networkError = NetworkError.generic(error)
                    promise(.failure(networkError))
                } else if let auth = auth {
                    promise(.success(AuthResponseDTO(auth)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signIn(withEmail email: String, link: String) -> AnyPublisher<AuthResponseDTO, NetworkError> {
        Future<AuthResponseDTO, NetworkError> { [weak self] promise in
            self?.auth.signIn(withEmail: email, link: link) { auth, error in
                if let error = error {
                    let networkError = NetworkError.generic(error)
                    promise(.failure(networkError))
                } else if let auth = auth {
                    promise(.success(AuthResponseDTO(auth)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signIn(with credential: AuthCredential) -> AnyPublisher<AuthResponseDTO, NetworkError> {
        Future<AuthResponseDTO, NetworkError> { [weak self] promise in
            self?.auth.signIn(with: credential) { auth, error in
                if let error = error {
                    let networkError = NetworkError.generic(error)
                    promise(.failure(networkError))
                } else if let auth = auth {
                    promise(.success(AuthResponseDTO(auth)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signInAnonymously() -> AnyPublisher<AuthResponseDTO, NetworkError> {
        Future<AuthResponseDTO, NetworkError> { [weak self] promise in
            self?.auth.signInAnonymously { auth, error in
                if let error = error {
                    let networkError = NetworkError.generic(error)
                    promise(.failure(networkError))
                } else if let auth = auth {
                    promise(.success(AuthResponseDTO(auth)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signIn(withCustomToken token: String) -> AnyPublisher<AuthResponseDTO, NetworkError> {
        Future<AuthResponseDTO, NetworkError> { [weak self] promise in
            self?.auth.signIn(withCustomToken: token) { auth, error in
                if let error = error {
                    let networkError = NetworkError.generic(error)
                    promise(.failure(networkError))
                } else if let auth = auth {
                    promise(.success(AuthResponseDTO(auth)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func createUser(withEmail email: String, password: String) -> AnyPublisher<AuthResponseDTO, NetworkError> {
        Future<AuthResponseDTO, NetworkError> { [weak self] promise in
            self?.auth.createUser(withEmail: email, password: password) { auth, error in
                if let error = error {
                    let networkError = NetworkError.generic(error)
                    promise(.failure(networkError))
                } else if let auth = auth {
                    promise(.success(AuthResponseDTO(auth)))
                }
            }
        }.eraseToAnyPublisher()
    }
}
