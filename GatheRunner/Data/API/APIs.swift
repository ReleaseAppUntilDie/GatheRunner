//
//  APIs.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/25.
//

import Combine

class APIs {
        
    class func requestAuth(firebaseOption option: FirebaseAPIManager.Option, _ request: AuthRequestDTO) -> AnyPublisher<AuthResponseDTO, NetworkError> {
        // MARK: - Temp guard fatalError()

        switch option {
        case .password:
            guard let email = request.email, let password = request.password else { fatalError() }
            return FirebaseAPIManager.shared.signIn(withEmail: email, password: password)
        case .link:
            guard let email = request.email, let link = request.link else { fatalError() }
            return FirebaseAPIManager.shared.signIn(withEmail: email, link: link)
            
        case .credential:
            guard let credential = request.credential else { fatalError() }
            return FirebaseAPIManager.shared.signIn(with: credential)

        case .anonymously:
            return FirebaseAPIManager.shared.signInAnonymously()

        case .customToken:
            guard let token = request.token else { fatalError() }
            return FirebaseAPIManager.shared.signIn(withCustomToken: token)
        }
    }
}

