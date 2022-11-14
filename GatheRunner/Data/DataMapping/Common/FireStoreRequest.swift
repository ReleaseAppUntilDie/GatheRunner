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

    var body: [String: Any]? {
        toDictionary
    }
}

protocol FireStoreRequestWithQuery: FireStoreRequest { }

extension FireStoreRequestWithQuery {
    var query: Query {
        targetCollection.addQueries(queries)
    }
}

protocol FireStoreRequestWithDocument: FireStoreRequest {
    var documentName: String { get }
}

extension FireStoreRequestWithDocument {
    var doc: DocumentReference {
        targetCollection.document(documentName)
    }
}
