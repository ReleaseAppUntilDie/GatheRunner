//
//  AuthenticationServiceProtocol.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/01.
//

import Combine
import FirebaseAuth

protocol AuthenticationServiceProtocol {
    func signIn(withEmail email: String, password: String) -> AnyPublisher<String, Error>
    func signUp(withEmail email: String, password: String) -> AnyPublisher<String, Error>
}
