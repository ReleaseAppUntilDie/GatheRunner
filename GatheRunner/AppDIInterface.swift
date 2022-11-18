//
//  AppDIInterface.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/18.
//

import Combine

protocol AppDIInterface {
    var userRepository: UserRepository { get }
}

enum PHASE {
    case FireBase
}

struct AppEnvironment {
    let phase: PHASE
}

class AppDI: AppDIInterface, ObservableObject {
    static let shared = AppDI(AppEnvironment(phase: .FireBase))
    
    private let appEnvironment: AppEnvironment
    
    private init(_ appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
    }
    
    lazy var userRepository: UserRepository = {
        switch appEnvironment.phase {
        case .FireBase:
            return FirebaseUserRepository()
        }
    }()
}
