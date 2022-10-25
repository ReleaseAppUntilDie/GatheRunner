//
//  AuthRequestBase.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/24.
//

import FirebaseAuth

// MARK: - AuthResponseDTO

struct AuthResponseDTO  {
    let uid: String
    let email: String
    let nickName: String
    
    init(_ authDataResult: AuthDataResult) {
        let user = authDataResult.user
        self.uid = user.uid
        self.email = user.email ?? Default.email
        self.nickName = user.displayName ?? Default.nickName
    }
}

// MARK: NameSpace

extension AuthResponseDTO {
    private enum Default {
        static let email = "지정된 이메일이 없습니다."
        static let nickName = "설정된 닉네임이 없습니다."
    }
}

// MARK: - AuthRequestDTO

struct AuthRequestDTO {
    let email: String?
    let password: String?
    let link: String?
    let credential: AuthCredential?
    let token: String?
}
