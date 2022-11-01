//
//  Encodable+FireStore.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/01.
//

import FirebaseFirestore

extension Encodable {
    var queries: [QueryOption] {
        var queries = [QueryOption]()
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            guard let key = child.label else { continue }

            let childMirror = Mirror(reflecting: child.value)
            switch childMirror.displayStyle {
            case .collection:
                ///temp 
                let children = (child.value as! [Encodable]).map { $0 }
                if children.count == 2 {
                    queries.append(.range(fieldPath: key, start: children[0], end: children[1]))
                } else {
                    queries.append(.equal(fieldPath: key, condition: child.value))
                }
            default:
                queries.append(.equal(fieldPath: key, condition: child.value))
            }
        }
        return queries
    }
}
