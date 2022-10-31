//
//  CollectionReference+Combine.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/31.
//

import Combine
import FirebaseFirestore

extension CollectionReference {
    func addDocumentWithAnyPublisher<T: Encodable>(from data: T) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { [weak self] promise in
            guard let encodedData = data.dictionary else { return }
            self?.addDocument(data: encodedData) { error in
                guard let error = error else {
                    promise(.success(true))
                    return
                }
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

}
