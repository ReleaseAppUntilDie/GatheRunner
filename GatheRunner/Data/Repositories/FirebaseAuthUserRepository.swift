//
//  FirebaseUserRepository.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/14.
//

import Foundation
import Combine

struct FirebaseUserRepository: UserRepository {
    func currentUser() -> AnyPublisher<AuthResponse, Error> {
        FirebaseAPIManager.shared.currentUser()
    }
    
    func signIn(_ request: AuthRequest) -> AnyPublisher<AuthResponse, Error> {
        let request = FirebaseAuthRequestDTO(request)
        guard let option = request.option else {
            return AnyPublisher(
                Fail<AuthResponse, Error>(error: NSError())
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
    
    func signUp(_ request: AuthRequest) -> AnyPublisher<AuthResponse, Error> {
        let request = FirebaseAuthRequestDTO(request)
        return FirebaseAPIManager.shared.createUser(withEmail: request.email, password: request.password)
    }
    
    func signOut() -> AnyPublisher<Bool, Error> {
        FirebaseAPIManager.shared.signOut()
    }
    
    func deleteUser() -> AnyPublisher<Bool, Error> {
        FirebaseAPIManager.shared.deleteUser()
    }
}
