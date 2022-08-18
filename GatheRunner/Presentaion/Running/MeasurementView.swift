//
//  MeasurementView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/16.
//

import SwiftUI

// MARK: - MeasurementView

struct MeasurementView: View {

    // MARK: Internal

    var body: some View {
        VStack(spacing: 30) {
            timerView
            otherInfoView
            onOffButton
        }
    }

    // MARK: Private

    @State private var progressTime = 0
    @State private var isRunning = false
    @State private var timer: Timer?
    @EnvironmentObject var manager: LocationManager

}

extension MeasurementView {
    var timerView: some View {
        VStack(spacing: 10) {
            Text("\(progressTime.minutes) : \(progressTime.seconds)")
                .font(.system(size: 40, weight: .bold))
            Text("운동 시간").asLabelStyle()
        }
    }

    var otherInfoView: some View {
        HStack(spacing: 30) {
            VStack(spacing: 10) {
                Text(String(format: "%.2f", manager.distance))
                    .font(.system(size: 40, weight: .bold))
                Text("킬로미터").asLabelStyle()
            }
            VStack(spacing: 10) {
                Text(String(format: "%.2f", manager.currentPace))
                    .font(.system(size: 40, weight: .bold))
                Text("페이스").asLabelStyle()
            }
        }
    }

    var onOffButton: some View {
        Toggle("", isOn: $isRunning)
            .onChange(of: isRunning) {
                guard $0 else {
                    timer?.invalidate()
                    return
                }
                manager.startingPoint = manager.region
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                    progressTime += 1
                })
            }
            .toggleStyle(IconStyle(onImage: "play", offImage: "stop"))
    }
}

// MARK: - MeasurementView_Previews

struct MeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementView().environmentObject(LocationManager())
    }
}
