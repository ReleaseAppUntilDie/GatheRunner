//
//  FirebaseAuthResponseDTO.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/24.
//

import FirebaseAuth

// MARK: - FirebaseAuthResponseDTO

extension AuthResponse {
    init(_ user: User) {
        uid = user.uid
        email = user.email ?? Default.email
        nickName = user.displayName ?? Default.nickName
    }
}
