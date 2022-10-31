//
//  CollectionReference+AddQueries.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/28.
//

import FirebaseFirestore

extension CollectionReference {
    func addQueries(_ queries: [QueryOption]?) -> Query {
        guard let queries = queries else {
            return self
        }
        for query in queries {
            switch query {
            case .equal(let fieldPath, let condition):
                whereField(fieldPath, isEqualTo: condition)
            case .contains(let fieldPath, let condition):
                whereField(fieldPath, isEqualTo: condition)
            case .notContains(let fieldPath, let condition):
                whereField(fieldPath, isEqualTo: condition)
            }
        }
        return self
    }
}
