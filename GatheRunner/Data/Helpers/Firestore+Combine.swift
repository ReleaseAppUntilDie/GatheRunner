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
    
    func firestoreGetTaskPublisher<D: Decodable>(
        as _: D.Type) -> AnyPublisher<D, Error>
    {
        getDocumentToPublisher
            .tryMap { try JSONDecoder().decode(D.self, fromJSONObject: $0.data()) }
            .eraseToAnyPublisher()
    }
    
    func firestoreGetTaskPublisher<D: Decodable>(
        as _: D.Type,
        querySnapshotMapper: @escaping (QuerySnapshot) -> [D] = QuerySnapshot.defaultMapper()) -> AnyPublisher<[D], Error>
    {
        getDocumentsToPublisher
            .map { querySnapshotMapper($0) }
            .eraseToAnyPublisher()
    }
    
    // MARK: Private
    
    private var getDocumentToPublisher: AnyPublisher<QueryDocumentSnapshot, Error> {
        Future<QueryDocumentSnapshot, Error> { [weak self] promise in
            self?.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else if let document = snapshot?.documents.first {
                    promise(.success(document))
                }
            }
        }.eraseToAnyPublisher()
    }
    
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
    fileprivate static func defaultMapper<D: Decodable>() -> (QuerySnapshot) -> [D] {
        { snapshot in
            var models: [D] = []
            snapshot.documents.forEach {
                do {
                    let model = try JSONDecoder().decode(D.self, fromJSONObject: $0.data())
                    models.append(model)
                } catch {
                    print("error \(error)")
                }
            }
            return models
        }
    }
}

extension CollectionReference {
    func firestorePostTaskPublisher(with data: [String: Any]?) -> AnyPublisher<Bool, Error> {
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
}

extension DocumentReference {
    func firestoreGetTaskPublisher<D: Decodable>(
        as _: D.Type) -> AnyPublisher<D, Error>
    {
        getDocumentToPublisher
            .tryMap { try JSONDecoder().decode(D.self, fromJSONObject: $0.data() as Any) }
            .eraseToAnyPublisher()
    }
    
    private var getDocumentToPublisher: AnyPublisher<DocumentSnapshot, Error> {
        Future<DocumentSnapshot, Error> { [weak self] promise in
            self?.getDocument { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else if let snapshot = snapshot {
                    promise(.success(snapshot))
                }
            }
        }.eraseToAnyPublisher()
    }
}
