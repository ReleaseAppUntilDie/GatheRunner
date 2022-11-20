//
//  FirebaseAuthRequestDTO.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/17.
//

// MARK: - FirebaseAuthRequestDTO

extension AuthRequest {
    var option: FirebaseAuthOption? {
        switch (email, password, link, token) {
        case (.some, .some, .none, .none):
            return .password
        case (.some, .none, .some, .none):
            return .link
        case (.none, .none, .none, .some):
            return .customToken
        case (.none, .none, .none, .none):
            return .anonymously
        default:
            return nil
        }
    }
}
