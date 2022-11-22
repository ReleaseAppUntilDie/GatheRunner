//
//  Query+AddQueries.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/28.
//

import FirebaseFirestore

extension Query {
    func addQueries(_ queries: [QueryOption]?) -> Query {
        if var queries = queries, queries.count > 0 {
            let query = queries.removeFirst()
            
            switch query {
            case .equal(let fieldPath, let condition):
                return self.whereField(fieldPath, isEqualTo: condition).addQueries(queries)
            case .range(let fieldPath, let start, let end):
                return self.whereField(fieldPath, isGreaterThanOrEqualTo: start).whereField(fieldPath, isLessThanOrEqualTo: end).addQueries(queries)
            }
            
        } else {
            return self
            
        }
    }
}
