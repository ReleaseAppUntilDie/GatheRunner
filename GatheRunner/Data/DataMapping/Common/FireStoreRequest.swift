//
//  FireStoreRequest.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/31.
//

import FirebaseFirestore
import Foundation

// MARK: - FireStoreRequest

protocol FireStoreRequest: Codable {
    var collectionName: String { get }
}

extension FireStoreRequest {
    var targetCollection: CollectionReference {
        Firestore.firestore().collection(collectionName)
    }

    var body: [String : Any]? {
        toDictionary
    }
    
    var dto: Query {
        targetCollection.addQueries(queries)
    }
}
