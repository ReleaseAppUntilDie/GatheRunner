//
//  MeasurementView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/16.
//

import SwiftUI

// MARK: - TimeRecord

struct TimeRecord: View {

    // MARK: Internal

    @StateObject private var manager = LocationManager()

    var timeUnit = 236
    var body: some View {
        VStack {
            timeView
            kilometerView
            startButton
        }
    }

    // MARK: Private

    @State private var progressTime = 236
    @State private var isRunning = false
    @State private var timer: Timer?

}

extension TimeRecord {
    var timeView: some View {
        HStack {
            Text("시간")
            Text("\(progressTime.minutes) : \(progressTime.seconds)").bold()
        }
    }

    var kilometerView: some View {
        VStack {
            Text("\(manager.distance)").bold()
            Text("킬로미터")
        }
    }

    var startButton: some View {
        Toggle("시작버튼", isOn: $isRunning)
            .onChange(of: isRunning) {
                if $0 {
                    timer?.invalidate()
                } else {
                    manager.startingPoint = manager.region
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                        progressTime += 1
                    })
                }
            }
    }
}

// MARK: - TimeRecord_Previews

struct TimeRecord_Previews: PreviewProvider {
    static var previews: some View {
        TimeRecord()
    }
}
