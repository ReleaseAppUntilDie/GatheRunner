//
//  CollectionReference+Combine.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/31.
//

import Combine
import FirebaseFirestore

extension CollectionReference {
    func addDocumentWithAnyPublisher(with data: [String : Any]?) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { [weak self] promise in
            guard let data = data else { return }
            self?.addDocument(data: data) { error in
                guard let error = error else {
                    promise(.success(true))
                    return
                }
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    func getDocumentWithAnyPublisher<D: Decodable>(queries: [QueryOption]?, type _: D.Type?) -> AnyPublisher<D, Error> {
        Future<D, Error> { [weak self] promise in
            self?.addQueries(queries)
                .limit(to: 1)
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

    func getDocumentWithAnyPublisher<D: Decodable>(queries: [QueryOption]?, type _: D.Type?) -> AnyPublisher<[D], Error> {
        var items = [D]()
        return Future<[D], Error> { [weak self] promise in
            self?.addQueries(queries)
                .addSnapshotListener { querySnapshot, error in
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
