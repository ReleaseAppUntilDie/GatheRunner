//
//  JSONDecoder+Decode.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/28.
//
import Foundation

extension JSONDecoder {
    func decode<T>(_: T.Type?, fromJSONObject object: Any) throws -> T where T: Decodable {
        try decode(T.self, from: try JSONSerialization.data(withJSONObject: object, options: []))
    }
}
