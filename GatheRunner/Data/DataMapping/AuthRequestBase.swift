//
//  AuthRequestBase.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/24.
//

// MARK: - AuthResponseDTO

struct AuthResponseDTO {
    let uid: String
    let email: String
    let nickName: String

    init(uid: String, email: String?, nickName: String?) {
        self.uid = uid
        self.email = email ?? Default.email
        self.nickName = nickName ?? Default.nickName
    }
}

// MARK: Decodable

extension AuthResponseDTO: Decodable {

    // MARK: Lifecycle

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        uid = try container.decodeIfPresent(String.self, forKey: .uid) ?? Default.empty
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? Default.email
        nickName = try container.decodeIfPresent(String.self, forKey: .nickName) ?? Default.nickName
    }

    // MARK: Internal

    enum Keys: String, CodingKey {
        case uid
        case email
        case nickName
    }
}

// MARK: NameSpace

extension AuthResponseDTO {
    private enum Default {
        static let empty = ""
        static let email = "지정된 이메일이 없습니다."
        static let nickName = "설정된 닉네임이 없습니다."
    }
}

// MARK: - AuthRequestDTO

struct AuthRequestDTO {
    let email: String
    let password: String
}
