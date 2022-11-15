//
//  RunningRecordView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/16.
//

import SwiftUI

// MARK: - RunningRecordView

struct RunningRecordView: View {
    
    // MARK: Internal
    
    var body: some View {
        VStack(spacing: Size.mainVerticalSpacing) {
            timerView
            realTimeRecordView
            stopWatchButtonLayer
        }
    }
    
    // MARK: Private
    
    private enum Size {
        static let defaultVerticalSpacing: CGFloat = 10
        static let mainVerticalSpacing: CGFloat = 30
        static let recordHorizontalSpacing: CGFloat = 30
        static let stopWatchHorizontalSpacing: CGFloat = 30
        static let stopWatchImage: CGFloat = 100
        static let labelFont: CGFloat = 40
    }
    
    private enum Content {
        enum Label {
            static let exerciseTime = "운동 시간"
            static let kilometer = "알림"
            static let pace = "페이스"
            static let recordFormat = "%.2f"
            static let empty = ""
        }
        
        enum Image {
            static let stop = "stop"
            static let play = "play"
            static let pause = "pause"
        }
    }
    
    @State private var isRunning = false
    @EnvironmentObject private var manager: LocationManager
}

// MARK: SubViews

extension RunningRecordView {
    private var timerView: some View {
        recordLabelView(
            label: Content.Label.exerciseTime,
            bidingText: "\(manager.minutes) : \(manager.seconds)")
    }
    
    private var realTimeRecordView: some View {
        HStack(spacing: Size.recordHorizontalSpacing) {
            recordLabelView(
                label: Content.Label.kilometer,
                bidingText: String(format: Content.Label.recordFormat, manager.distance))
            recordLabelView(
                label: Content.Label.pace,
                bidingText: String(format: Content.Label.recordFormat, manager.currentPace))
        }
    }
    
    private var stopWatchButtonLayer: some View {
        HStack(spacing: Size.stopWatchHorizontalSpacing) {
            stopButton.isEmpty(logicalOperator: .none, [isRunning == true])
            resumeButton
        }
    }
    
    private var stopButton: some View {
        Button(action: { }) {
            Image(Content.Image.stop)
                .asIconStyle(withMaxWidth: Size.stopWatchImage, withMaxHeight: Size.stopWatchImage)
                .addLongPressTypeAlert(withAction: manager.didUnSetStartLocation)
        }
    }
    
    private var resumeButton: some View {
        Toggle(Content.Label.empty, isOn: $isRunning)
            .onChange(of: isRunning) {
                $0 ? manager.didSetStartLocation() : manager.didUnSetStartLocation()
            }
            .toggleStyle(IconStyle(onImage: Content.Image.play, offImage: Content.Image.pause, size: Size.stopWatchImage))
    }
    
    private func recordLabelView(
        spacing: CGFloat = Size.defaultVerticalSpacing,
        font: Font = .system(size: Size.labelFont, weight: .bold),
        label: String,
        bidingText: String)
    -> some View
    {
        VStack(spacing: spacing) {
            Text(bidingText)
                .font(font)
            Text(label).asLabelStyle()
        }
    }
}

// MARK: - RunningRecordView_Previews
struct RunningRecordView_Previews: PreviewProvider {
    static var previews: some View {
        RunningRecordView().environmentObject(LocationManager())
    }
}
