//
//  Auth+Combine.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/27.
//

import Combine
import FirebaseAuth

extension Auth {
    public func signIn(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
        Future<AuthDataResult, Error> { [weak self] promise in
            self?.signIn(withEmail: email, password: password) { auth, error in
                if let error = error {
                    promise(.failure(error))
                } else if let auth = auth {
                    promise(.success(auth))
                }
            }
        }.eraseToAnyPublisher()
    }

    public func signIn(with credential: AuthCredential) -> AnyPublisher<AuthDataResult, Error> {
        Future<AuthDataResult, Error> { [weak self] promise in
            self?.signIn(with: credential) { auth, error in
                if let error = error {
                    promise(.failure(error))
                } else if let auth = auth {
                    promise(.success(auth))
                }
            }
        }.eraseToAnyPublisher()
    }

    public func createUser(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
        Future<AuthDataResult, Error> { [weak self] promise in
            self?.createUser(withEmail: email, password: password) { auth, error in
                if let error = error {
                    promise(.failure(error))
                } else if let auth = auth {
                    promise(.success(auth))
                }
            }
        }.eraseToAnyPublisher()
    }
}
