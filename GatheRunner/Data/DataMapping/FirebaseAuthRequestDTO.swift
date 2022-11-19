//
//  FirebaseAuthRequestDTO.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/17.
//

import FirebaseAuth

struct FirebaseAuthRequestDTO {
    let option: AuthOption?
    let email: String?
    let password: String?
    let link: String?
    let credential: AuthCredential?
    let token: String?
    
    init(option: AuthOption? = nil,
         email: String? = nil,
         password: String? = nil,
         link: String? = nil,
         credential: AuthCredential? = nil,
         token: String? = nil) {
        self.option = option
        self.email = email
        self.password = password
        self.link = link
        self.credential = credential
        self.token = token
    }
}

extension FirebaseAuthRequestDTO {
    init(_ request: AuthRequest) {
        self.init(option: .password, email: request.email, password: request.password)
    }
}
