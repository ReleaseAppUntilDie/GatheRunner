//
//  MockAuthenticationService.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/09/01.
//

import Combine
import FirebaseAuth
import Foundation
@testable import GatheRunner

struct MockAuthenticationService: AuthenticationServiceProtocol {
    let isSuccess: Bool

    func signIn(withEmail _: String, password _: String) -> AnyPublisher<String, Error> {
        let publisher = PassthroughSubject<String, Error>()
        let error = URLError(.badServerResponse)
        isSuccess == true ? publisher.send("success") : publisher.send(completion: .failure(error))
        return publisher.eraseToAnyPublisher()
    }

    func signUp(withEmail _: String, password _: String) -> AnyPublisher<String, Error> {
        let publisher = PassthroughSubject<String, Error>()
        let error = URLError(.badServerResponse)
        isSuccess == true ? publisher.send("success") : publisher.send(completion: .failure(error))
        return publisher.eraseToAnyPublisher()
    }
}
