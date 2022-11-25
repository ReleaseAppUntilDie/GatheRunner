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
            RunningRouteView(viewModel: routeVm).isEmpty(logicalOperator: .and, [isStart, !isRunning])
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
            static let kilometer = "거리"
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
    @State private var isStart = false
    @StateObject var recordVm: RunningRecordViewModel
    @StateObject var routeVm: RunningRouteViewModel
}

// MARK: SubViews

extension RunningRecordView {
    private var timerView: some View {
        recordLabelView(
            label: Content.Label.exerciseTime,
            bidingText: "\(recordVm.minutes) : \(recordVm.seconds)")
    }
    
    private var realTimeRecordView: some View {
        HStack(spacing: Size.recordHorizontalSpacing) {
            recordLabelView(
                label: Content.Label.kilometer,
                bidingText: String(format: Content.Label.recordFormat, recordVm.distance))
            recordLabelView(
                label: Content.Label.pace,
                bidingText: String(format: Content.Label.recordFormat, recordVm.currentPace))
        }
    }
    
    private var stopWatchButtonLayer: some View {
        HStack(spacing: Size.stopWatchHorizontalSpacing) {
            stopButton.isEmpty(logicalOperator: .none, [isRunning])
            resumeButton
        }
    }
    
    private var stopButton: some View {
        Button(action: { }) {
            Image(Content.Image.stop)
                .asIconStyle(withMaxWidth: Size.stopWatchImage, withMaxHeight: Size.stopWatchImage)
                .addLongPressTypeAlert {
                    isRunning = false
                    isStart = false
                    stopRecord()
                }
        }
    }
    
    private var resumeButton: some View {
        Toggle(Content.Label.empty, isOn: $isRunning)
            .onChange(of: isRunning) {
                isStart = true
                $0 ? recordVm.startRecord() : recordVm.pauseRecord()
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
    
    private func startRecord() {
        recordVm.startRecord()
        routeVm.startRecord()
    }
    
    private func pauseRecord() {
        recordVm.pauseRecord()
        routeVm.pauseRecord()
    }
    
    private func stopRecord() {
        recordVm.stopRecord()
        routeVm.stopRecord()
    }

}

// MARK: - RunningRecordView_Previews

//struct RunningRecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunningRecordView().environmentObject(LocationManager())
//    }
//}
