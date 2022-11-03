//
//  Firestore+Combine.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/03.
//

import Combine
import FirebaseFirestore

extension Query {

    // MARK: Internal

    func firestoreTaskPublisher<D: Decodable>(
        source _: FirestoreSource = .default,
        as _: D.Type,
        querySnapshotMapper: @escaping (QuerySnapshot) -> [D] = QuerySnapshot.defaultMapper()) -> AnyPublisher<[D], Error>
    {
        getDocumentsToPublisher
            .map { querySnapshotMapper($0) }
            .eraseToAnyPublisher()
    }

    // MARK: Private

    private var getDocumentsToPublisher: AnyPublisher<QuerySnapshot, Error> {
        Future<QuerySnapshot, Error> { [weak self] promise in
            self?.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else if let snapshot = snapshot {
                    promise(.success(snapshot))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension QuerySnapshot {
    public static func defaultMapper<D: Decodable>() -> (QuerySnapshot) -> [D] {
        { snapshot in
            var dArray: [D] = []
            snapshot.documents.forEach {
                do {
                    let d = try JSONDecoder().decode(D.self, fromJSONObject: $0.data())
                    dArray.append(d)
                } catch {
                    print("\(error)")
                }
            }
            return dArray
        }
    }
}

