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

    func fetch<D: Decodable>(withQuery request: FireStoreRequestWithQuery, as _: D.Type) -> AnyPublisher<D, Error> {
        request.query.firestoreGetTaskPublisher(as: D.self)
    }
    
    func fetch<D: Decodable>(withDocument request: FireStoreRequestWithDocument, as _: D.Type) -> AnyPublisher<D, Error> {
        request.doc.firestoreGetTaskPublisher(as: D.self)
    }
    
    func fetch<D: Decodable>(withQuery request: FireStoreRequestWithQuery, as _: D.Type) -> AnyPublisher<[D], Error> {
        request.query.firestoreGetTaskPublisher(as: D.self)
    }

    func post(request: FireStoreRequest) -> AnyPublisher<Bool, Error> {
        request.targetCollection.firestorePostTaskPublisher(with: request.body)
    }
}
