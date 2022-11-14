//
//  UserRepository.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/14.
//

import Combine

protocol UserRepository {
    associatedtype Request
    associatedtype Response
    
    func currentUser() -> AnyPublisher<Response, Error>
    func signIn(request: Request) -> AnyPublisher<Response, Error>
    func signUp(request: Request) -> AnyPublisher<Response, Error>
    func signOut() -> AnyPublisher<Bool, Error>
    func deleteUser(request: Request) -> AnyPublisher<Bool, Error>
}
