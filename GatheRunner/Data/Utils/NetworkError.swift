//
//  NetworkError.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/24.
//

import Foundation

// MARK: - NetworkError

enum NetworkError: Error {
    case error(message: String)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

// MARK: LocalizedError

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .error(let message):
            return message
        case .notConnected:
            return "notConnected"
        case .cancelled:
            return "cancelled"
        case .generic(let Error):
            return String("\(Error)")
        case .urlGeneration:
            return "urlError"
        }
    }
}
