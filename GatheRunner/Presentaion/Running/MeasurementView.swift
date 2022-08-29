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
                .accessibilityIdentifier("onOffButton")
        }
    }

    // MARK: Private

    @State private var isRunning = false
    @EnvironmentObject var manager: LocationManager
}

extension MeasurementView {
    var timerView: some View {
        VStack(spacing: 10) {
            Text("\(manager.minutes) : \(manager.seconds)")
                .font(.system(size: 40, weight: .bold))
                .accessibilityIdentifier("timerView")
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
                    manager.didUnSetStartLocation()
                    return
                }
                manager.didSetStartLocation()
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