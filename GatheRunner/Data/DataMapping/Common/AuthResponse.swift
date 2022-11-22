//
//  AuthResponse.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/14.
//

struct AuthResponse: Decodable {
    let uid: String
    let email: String
    let nickName: String
    
    enum Keys: String, CodingKey {
        case uid
        case email
        case nickName
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        uid = try container.decodeIfPresent(String.self, forKey: .uid) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? Default.email
        nickName = try container.decodeIfPresent(String.self, forKey: .nickName) ?? Default.nickName
    }
}

// MARK: NameSpace

extension AuthResponse {
    enum Default {
        static let email = "지정된 이메일이 없습니다."
        static let nickName = "설정된 닉네임이 없습니다."
    }
}
