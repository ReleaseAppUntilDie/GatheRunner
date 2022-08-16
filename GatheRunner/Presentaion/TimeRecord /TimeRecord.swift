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

    var hours: Int {
        progressTime / 3600
    }

    var minutes: Int {
        (progressTime % 3600) / 60
    }

    var seconds: Int {
        progressTime % 60
    }

    var body: some View {
        VStack {
            timerView
            startButton
        }
    }

    // MARK: Private

    @State private var progressTime = 236
    @State private var isRunning = false
    @State private var timer: Timer?

}

extension TimeRecord {

    var timerView: some View {
        HStack(spacing: 10) {
            StopwatchUnit(timeUnit: hours)
            Text(":")
                .font(.system(size: 48))
                .foregroundColor(.white)
                .offset(y: -18)
            StopwatchUnit(timeUnit: minutes)
            Text(":")
                .font(.system(size: 48))
                .foregroundColor(.white)
                .offset(y: -18)
            StopwatchUnit(timeUnit: seconds)
        }
    }

    var startButton: some View {
        Button(action: {
            if isRunning {
                timer?.invalidate()
            } else {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                    progressTime += 1
                })
            }
            isRunning.toggle()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 15.0)
                    .frame(width: 120, height: 50, alignment: .center)
                    .foregroundColor(isRunning ? .blue : .green)

                Text(isRunning ? "Stop" : "Start")
                    .font(.title)
                    .foregroundColor(.white)
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

