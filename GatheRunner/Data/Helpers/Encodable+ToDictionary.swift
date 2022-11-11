//
//  Encodable+ToDictionary.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/29.
//

import Foundation

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any] }
    }
}
