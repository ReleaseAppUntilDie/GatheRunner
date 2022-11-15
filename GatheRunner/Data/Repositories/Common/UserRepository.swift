//
//  UserRepository.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/14.
//

import Combine

protocol UserRepository {
    func currentUser() -> AnyPublisher<FirebaseAuthResponseDTO, Error>
    func signIn(request: FirebaseAuthRequestDTO) -> AnyPublisher<FirebaseAuthResponseDTO, Error>
    func signUp(request: FirebaseAuthRequestDTO) -> AnyPublisher<FirebaseAuthResponseDTO, Error>
    func signOut() -> AnyPublisher<Bool, Error>
    func deleteUser(request: FirebaseAuthRequestDTO) -> AnyPublisher<Bool, Error>
}
