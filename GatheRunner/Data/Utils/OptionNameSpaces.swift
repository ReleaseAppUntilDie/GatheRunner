//
//  OptionNameSpaces.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/28.
//

// MARK: - QueryOption

enum QueryOption {
    case equal(fieldPath: String, condition: Any)
    case range(fieldPath: String, start: Any, end: Any)
}

// MARK: - AuthOption

enum AuthOption {
    case password
    case link
    case credential
    case anonymously
    case customToken
}
