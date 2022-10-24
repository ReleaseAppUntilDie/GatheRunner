//
//  APIManger+AuthRequest.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/24.
//

import Combine
import FirebaseAuth

extension APIManger {
    func request(requestOption option: RequestOption, _ request: AuthRequestDTO) -> AnyPublisher<AuthResponseDTO, NetworkError> {
        switch option {
        case .withFirebaseAuth: return signIn(request: request)
        }
    }
}

extension APIManger {
    private func signIn(request: AuthRequestDTO) -> AnyPublisher<AuthResponseDTO, NetworkError> {
        Future<AuthResponseDTO, NetworkError> { promise in
            Auth.auth().signIn(withEmail: request.email, password: request.password) { auth, error in
                if let error = error {
                    let networkError = NetworkError.generic(error)
                    promise(.failure(networkError))
                } else if let user = auth?.user {
                    let response = AuthResponseDTO(uid: user.uid, email: user.email, nickName: user.displayName)
                    promise(.success(response))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
