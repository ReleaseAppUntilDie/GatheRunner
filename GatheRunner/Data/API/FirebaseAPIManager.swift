//
//  FirebaseAPIManager.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/27.
//

import Combine

// MARK: - FirebaseAPIManager

class FirebaseAPIManager {
    static let shared = FirebaseAPIManager()

    func fetch<D: Decodable>(request: FireStoreRequest, as _: D.Type) -> AnyPublisher<[D], Error> {
        request.dto.firestoreTaskPublisher(as: D.self)
    }
}
