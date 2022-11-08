//
//  Encodable+Queries.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/01.
//

extension Encodable {
    var queries: [QueryOption] {
        var queries = [QueryOption]()
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            guard let key = child.label else { continue }
            var value = child.value
            let childMirror = Mirror(reflecting: child.value)
            
            switch childMirror.displayStyle {
            case .collection:
                guard let children = child.value as? [Any] else { continue }
                
                guard children.count == 2 else {
                    value = children[0]
                    fallthrough
                }
                
                queries.append(.range(fieldPath: key, start: children[0], end: children[1]))
                
            default:
                queries.append(.equal(fieldPath: key, condition: value))
            }
        }
        return queries
    }
}
