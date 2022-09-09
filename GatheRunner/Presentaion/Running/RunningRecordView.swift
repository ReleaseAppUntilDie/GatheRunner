//
//  RunningRecordView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/16.
//

import SwiftUI

// MARK: - RunningRecordView

struct RunningRecordView: View {

    // MARK: Internal runningRecordView

    var body: some View {
        VStack(spacing: 30) {
            timerView
            realTimeRecordView
            stopWatchButttons
        }
    }

    // MARK: Private

    @State private var isRunning = false
    @EnvironmentObject var manager: LocationManager
}

extension RunningRecordView {
    var timerView: some View {
        VStack(spacing: 10) {
            Text("\(manager.minutes) : \(manager.seconds)")
                .font(.system(size: 40, weight: .bold))
                .accessibilityIdentifier("timerView")
            Text("운동 시간").asLabelStyle()
        }
    }

    var realTimeRecordView: some View {
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

    var stopWatchButttons: some View {
        HStack(spacing: 20) {
            stopButton
                .isEmpty(logicalOperator: .none, [isRunning == true])
            resumeButton
                .accessibilityIdentifier("resumeButton")
        }
    }

    var stopButton: some View {
        Button(action: { }) {
            Image("stop")
                .asIconStyle(withMaxWidth: 82, withMaxHeight: 82)
                .setAlertWhenTappedAndLongPress(withAction: manager.didUnSetStartLocation, alertText: "길게 눌러주세요.")
        }
    }

    var resumeButton: some View {
        Toggle("", isOn: $isRunning)
            .onChange(of: isRunning) {
                guard $0 else {
                    manager.didUnSetStartLocation()
                    return
                }
                manager.didSetStartLocation()
            }
            .toggleStyle(IconStyle(onImage: "play", offImage: "pause", size: 100))
    }
}

// MARK: - RunningRecordView_Previews

struct RunningRecordView_Previews: PreviewProvider {
    static var previews: some View {
        RunningRecordView().environmentObject(LocationManager())
    }
}
