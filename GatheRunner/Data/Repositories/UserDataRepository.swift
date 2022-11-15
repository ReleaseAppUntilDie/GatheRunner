//
//  UserDataRepository.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/14.
//

import Foundation
import Combine

struct UserDataRepository: UserRepository {    
    func currentUser() -> AnyPublisher<FirebaseAuthResponseDTO, Error> {
        FirebaseAPIManager.shared.currentUser()
    }
    
    func signIn(request: FirebaseAuthRequestDTO) -> AnyPublisher<FirebaseAuthResponseDTO, Error> {
        guard let option = request.option else {
            return AnyPublisher(
                Fail<FirebaseAuthResponseDTO, Error>(error: NSError())
            )
        }
        
        switch option {
        case .password:
            return FirebaseAPIManager.shared.signIn(withEmail: request.email, password: request.password)
            
        case .link:
            return FirebaseAPIManager.shared.signIn(withEmail: request.email, link: request.link)
            
        case .credential:
            return FirebaseAPIManager.shared.signIn(with: request.credential)
            
        case .anonymously:
            return FirebaseAPIManager.shared.signInAnonymously()
            
        case .customToken:
            return FirebaseAPIManager.shared.signIn(withCustomToken: request.token)
        }
    }
    
    func signUp(request: FirebaseAuthRequestDTO) -> AnyPublisher<FirebaseAuthResponseDTO, Error> {
        FirebaseAPIManager.shared.createUser(withEmail: request.email, password: request.password)
    }
    
    func signOut() -> AnyPublisher<Bool, Error> {
        FirebaseAPIManager.shared.signOut()
    }
    
    func deleteUser(request: FirebaseAuthRequestDTO) -> AnyPublisher<Bool, Error> {
        FirebaseAPIManager.shared.deleteUser()
    }
}
