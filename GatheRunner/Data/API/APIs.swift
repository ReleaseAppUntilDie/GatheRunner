//
//  APIs.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/25.
//

import Combine

class APIs {
    func requestAuth(
        firebaseOption option: AuthOption,
        _ request: AuthRequestDTO) -> AnyPublisher<AuthResponseDTO, NetworkError>
    {
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
}
