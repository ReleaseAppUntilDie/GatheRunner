//
//  AuthRequest.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/17.
//

struct AuthRequest: Codable {
    let email: String?
    let password: String?
    let link: String?
    let token: String?
}

extension AuthRequest {
    init(email: String, password: String) {
        self.init(email: email, password: password, link: nil, token: nil)
    }
    
    init(email: String, link: String) {
        self.init(email: email, password: nil, link: link, token: nil)
    }
    
    init(token: String) {
        self.init(email: nil, password: nil, link: nil, token: token)
    }
    
    init() {
        self.init(email: nil, password: nil, link: nil, token: nil)
    }
}
