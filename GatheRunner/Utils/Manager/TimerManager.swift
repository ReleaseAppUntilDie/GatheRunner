//
//  TimerManager.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/24.
//

import Combine
import SwiftUI

class TimerManager: ObservableObject {
    @Published var progressTime = 0
    
    private var timerCancellable: Cancellable?
    
    func bind() {
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.progressTime += 1
            }
    }
    
    func cancleBinding() {
        timerCancellable?.cancel()
    }
    
    func resetTime() {
        progressTime = 0
    }
}
