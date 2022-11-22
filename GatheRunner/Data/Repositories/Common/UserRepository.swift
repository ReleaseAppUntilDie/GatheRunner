//
//  UserRepository.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/14.
//

import Combine

protocol UserRepository {
    func currentUser() -> AnyPublisher<AuthResponse, Error>
    func signIn(_ request: AuthRequest) -> AnyPublisher<AuthResponse, Error>
    func signUp(_ request: AuthRequest) -> AnyPublisher<AuthResponse, Error>
    func signOut() -> AnyPublisher<Bool, Error>
    func deleteUser() -> AnyPublisher<Bool, Error>
}
