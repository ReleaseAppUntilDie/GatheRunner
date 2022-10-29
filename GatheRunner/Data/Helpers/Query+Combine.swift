//
//  Query+Combine.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/28.
//
import Combine
import FirebaseFirestore

extension Query {
    func map<D: Decodable>(decodeWith _: D.Type) -> AnyPublisher<D, Error> {
        return Future<D, Error> { [weak self] promise in
            self?.limit(to: 1)
                .addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        promise(.failure(error))
                    } else if let document = querySnapshot?.documents.first {
                        guard let data = try? JSONDecoder().decode(D.self, fromJSONObject: document.data()) else {
                            return
                        }
                        promise(.success(data))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    
    func map<D: Decodable>(decodeWith _: D.Type) -> AnyPublisher<[D], Error> {
        var items = [D]()
        return Future<[D], Error> { [weak self] promise in
            self?.addSnapshotListener { querySnapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else if let documents = querySnapshot?.documents {
                    for eachDoc in documents {
                        guard let data = try? JSONDecoder().decode(D.self, fromJSONObject: eachDoc.data()) else {
                            return
                        }
                        items.append(data)
                    }
                    promise(.success(items))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
