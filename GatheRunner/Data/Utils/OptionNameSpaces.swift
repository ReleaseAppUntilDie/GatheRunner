//
//  OptionNameSpaces.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/28.
//

// MARK: - QueryOption

enum QueryOption {
    case equal(fieldPath: String, condition: String)
    case contains(fieldPath: String, condition: String)
    case notContains(fieldPath: String, condition: String)
    case range(fieldPath: String, start: String, end: String)
}

// MARK: - AuthOption

enum AuthOption {
    case password
    case link
    case credential
    case anonymously
    case customToken
}

// MARK: - CollectionOption

enum CollectionOption: String {
    case runningRecord = "RunningRecord"
    case weatherInfo = "WeatherInfo"
}
