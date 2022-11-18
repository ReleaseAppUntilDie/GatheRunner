//
//  AuthRequest.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/17.
//

import Foundation

struct AuthRequest: Codable {
    let email: String
    let password: String
}
