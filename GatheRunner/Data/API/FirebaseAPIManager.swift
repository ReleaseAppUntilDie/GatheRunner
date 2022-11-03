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

    func fetchOnce<D: Decodable>(request: FireStoreRequest) -> AnyPublisher<D, Error> {
        let type = request.responseType.self as? D.Type
        return request.targetCollection.getDocumentWithPublisher(queries: request.queries, as: type)
    }

    func fetch<D: Decodable>(request: FireStoreRequest) -> AnyPublisher<[D], Error> {
        let type = request.responseType.self as? D.Type
        return request.targetCollection.getDocumentWithPublisher(queries: request.queries, as: type)
    }

    func post(request: FireStoreRequest) -> AnyPublisher<Bool, Error> {
        request.targetCollection.addDocumentWithPublisher(with: request.body)
    }
}
