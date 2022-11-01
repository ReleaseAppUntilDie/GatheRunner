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

    func fetch<D: Decodable>(request: FireStoreRequest) -> AnyPublisher<D, Error> {
        let decodeType = request.responseType.self as? D.Type
        return request.targetCollection.getDocumentWithAnyPublisher(queries: request.queries, type: decodeType)
    }

    func fetchs<D: Decodable>(request: FireStoreRequest) -> AnyPublisher<[D], Error> {
        let decodeType = request.responseType.self as? D.Type
        return request.targetCollection.getDocumentWithAnyPublisher(queries: request.queries, type: decodeType)
    }

    func post(request: FireStoreRequest) -> AnyPublisher<Bool, Error> {
        request.targetCollection.addDocumentWithAnyPublisher(with: request.body)
    }
}
