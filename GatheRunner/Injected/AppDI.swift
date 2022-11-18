//
//  AppDI.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/18.
//

import Combine

protocol AppDIInterface {
    var userRepository: UserRepository { get }
}

class AppDI: AppDIInterface, ObservableObject {
    private let appEnvironment: AppEnvironment
    
    init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
    }
    
    lazy var userRepository: UserRepository = {
        switch appEnvironment.apiType {
        case .FireBase:
            return FirebaseUserRepository()
        }
    }()
}
