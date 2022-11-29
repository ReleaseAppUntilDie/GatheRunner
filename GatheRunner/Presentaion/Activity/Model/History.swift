//
//  History.swift
//  GatheRunner
//
//  Created by 모바일개발팀/한재승 on 2022/10/12.
//

import Combine
import Foundation

struct RunningRecordRequest {
    let uid: String
}

extension RunningRecordRequest: FireStoreRequestWithQuery {
    var collectionName: String {
        "RunningRecord"
    }
}

struct History: Decodable, Identifiable {

    var id: String { (distance ?? "") + (date ?? "") }
    let distance: String?
    let averagePace: String?
    let runningTime: String?
    let date: String?
    let uid: String?
    
    var stringToDate: Date {
        let dateString = self.date!
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter.date(from: dateString)!
    }
    
    var weekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "EEEEEE"
        let convertStr = dateFormatter.string(from: self.stringToDate)
        return "\(convertStr)요일"
    }
}

class RunningRecordAPIs {
    static var cancelBag = Set<AnyCancellable>()

    static func fetchRunningRecord(request: RunningRecordRequest) -> AnyPublisher<[History], Error> {
        
        FirebaseAPIManager.shared.fetch(withQuery: request, as: History.self)
    }
}
