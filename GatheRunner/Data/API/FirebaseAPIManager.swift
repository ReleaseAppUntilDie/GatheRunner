//
//  FirebaseAPIManager.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/27.
//

import Combine
import FirebaseFirestore

// MARK: - FirebaseAPIManager

class FirebaseAPIManager {

    // MARK: Internal

    static let shared = FirebaseAPIManager()

    func fetch<D: Decodable>(
        collection: CollectionOption,
        queries: [QueryOption]? = nil,
        as type: D.Type) -> AnyPublisher<D, Error>
    {
        db.collection(collection.rawValue)
            .addQueries(queries)
            .getDocumentWithAnyPublisher(decodeWith: type)
    }

    func fetch<D: Decodable>(
        collection: CollectionOption,
        queries: [QueryOption]? = nil,
        as type: D.Type) -> AnyPublisher<[D], Error>
    {
        db.collection(collection.rawValue)
            .addQueries(queries)
            .getDocumentWithAnyPublisher(decodeWith: type)
    }

    func post<T: Encodable>(
        collection: CollectionOption,
        from data: T) -> AnyPublisher<Bool, Error>
    {
        db.collection(collection.rawValue)
            .addDocumentWithAnyPublisher(from: data)
    }

    // MARK: Private

    private let db = Firestore.firestore()
}
