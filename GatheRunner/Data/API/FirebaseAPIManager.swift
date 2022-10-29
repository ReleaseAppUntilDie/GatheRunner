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
    
    func getDocument<D: Decodable>(
        collection: CollectionOption,
        queries: [QueryOption]? = nil,
        as type: D.Type) -> AnyPublisher<[D], Error>
    {
        db.collection(collection.rawValue)
            .addQueries(queries)
            .map(decodeWith: type)
    }

    func getDocuments<D: Decodable>(
        collection: CollectionOption,
        queries: [QueryOption]? = nil,
        as type: D.Type) -> AnyPublisher<[D], Error>
    {
        db.collection(collection.rawValue)
            .addQueries(queries)
            .map(decodeWith: type)
    }

    // MARK: Private

    private let db = Firestore.firestore()
}
