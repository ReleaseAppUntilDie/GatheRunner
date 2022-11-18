//
//  AppDIInterface.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/18.
//

import Combine

protocol AppDIInterface {
    var userRepository: UserRepository { get }
    var authInteractor: AuthInteractor { get }
    var authViewModel: AuthenticationViewModel { get }
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
    
    lazy var authInteractor: AuthInteractor = {
        return AuthInteractor(userRepository: userRepository)
    }()
    
    lazy var authViewModel: AuthenticationViewModel = {
        return AuthenticationViewModel(userRepository: userRepository, authInteractor: authInteractor)
    }()
}
