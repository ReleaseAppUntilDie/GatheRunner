//
//  FetchStatusType.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/29.
//

import Foundation

struct FetchStatusType: Equatable {
    init(status: FetchStatus, type: FetchType) {
        self.status = status
        self.type = type
    }

    let status: FetchStatus
    let type: FetchType

    var isInitial: Bool {
        type == .initial
    }

    var isMore: Bool {
        type == .more
    }

    var isRefresh: Bool {
        type == .refresh
    }

    var isNone: Bool {
        status == .none
    }

    var isFetching: Bool {
        status == .fetching
    }

    var isSuccess: Bool {
        status == .success
    }

    var isFailure: Bool {
        if case .failure = status {
            return true
        } else {
            return false
        }
    }

    var isLoadMore: Bool {
        isMore && isFetching
    }

    static func none(_ type: FetchType) -> Self {
        .init(status: .none, type: type)
    }

    static func fetching(_ type: FetchType) -> Self {
        .init(status: .fetching, type: type)
    }

    static func success(_ type: FetchType) -> Self {
        .init(status: .success, type: type)
    }

    static func failure(_ type: FetchType) -> Self {
        .init(status: .failure, type: type)
    }
}

enum FetchType {
    case initial
    case more
    case refresh
}

enum FetchStatus: Equatable {
    case none
    case fetching
    case success
    case failure

    var isFailed: Bool {
        switch self {
        case .failure: return true
        default: return false
        }
    }

    static func == (lhs: FetchStatus, rhs: FetchStatus) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none),
            (.fetching, .fetching),
            (.success, .success),
            (.failure, .failure):
            return true
        default:
            return false
        }
    }

    static func === (lhs: FetchStatus, rhs: FetchStatus) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none),
            (.fetching, .fetching),
            (.success, .success),
            (.failure, .failure):
            return true
        default:
            return false
        }
    }
}
