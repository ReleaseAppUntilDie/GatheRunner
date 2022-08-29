//
//  AuthAPI.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/27.
//

import Combine
import FirebaseAuth

class AuthenticationService {
    static func signIn(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
        Auth.auth().signIn(withEmail: email, password: password) as AnyPublisher<AuthDataResult, Error>
    }

    static func createUser(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
        Auth.auth().createUser(withEmail: email, password: password) as AnyPublisher<AuthDataResult, Error>
    }
}
