//
//  FirebaseAuthRequestDTO.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/17.
//

import FirebaseAuth

struct FirebaseAuthRequestDTO {
    let option: FirebaseAuthOption?
    let email: String?
    let password: String?
    let link: String?
    let credential: AuthCredential?
    let customToken: String?
    
    init(option: FirebaseAuthOption? = nil,
         email: String? = nil,
         password: String? = nil,
         link: String? = nil,
         credential: AuthCredential? = nil,
         customToken: String? = nil) {
        self.option = option
        self.email = email
        self.password = password
        self.link = link
        self.credential = credential
        self.customToken = customToken
    }
}

extension FirebaseAuthRequestDTO {
    init(_ request: AuthRequest) {
        switch (request.email, request.password, request.link, request.token) {
        case (.some, .some, .none, .none):
            self.init(option: .password, email: request.email, password: request.password)
        case (.none, .none, .some, .none):
            self.init(option: .link, link: request.link)
        case (.none, .none, .none, .some):
            self.init(option: .customToken, customToken: request.token)
        case (.none, .none, .none, .none):
            self.init(option: .anonymously)
        default:
            self.init()
        }
    }
}
