//
//  AuthAPI.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/27.
//

import Combine
import FirebaseAuth

class AuthenticationService: AuthenticationServiceProtocol {
    func signIn(withEmail email: String, password: String) -> AnyPublisher<String, Error> {
        Future<String, Error> { promise in
            Auth.auth().signIn(withEmail: email, password: password) { auth, error in
                if let error = error {
                    promise(.failure(error))
                } else if let auth = auth {
                    promise(.success(auth.user.refreshToken ?? ""))
                }
            }
        }.eraseToAnyPublisher()
    }

    func signUp(withEmail email: String, password: String) -> AnyPublisher<String, Error> {
        Future<String, Error> { promise in
            Auth.auth().createUser(withEmail: email, password: password) { auth, error in
                if let error = error {
                    promise(.failure(error))
                } else if let auth = auth {
                    promise(.success(auth.user.refreshToken ?? ""))
                }
            }
        }.eraseToAnyPublisher()
    }
}
