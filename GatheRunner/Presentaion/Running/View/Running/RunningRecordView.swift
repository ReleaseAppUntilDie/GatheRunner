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
            runningRouteView
            timerView
            realTimeRecordView
            stopWatchButtonLayer
        }
        .onAppear {
            bindViewModel()
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
        static let routeCornerRadius: CGFloat = 15
        static let routePadding: CGFloat = 30
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
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isRunning = false
    @State private var isResume = false
    @StateObject var recordVm: RunningRecordViewModel
    
    var routeVm: RunningRouteViewModel
}

// MARK: SubViews

extension RunningRecordView {
    private var runningRouteView: some View {
        RunningRouteView(routeVm: routeVm)
            .isEmpty(logicalOperator: .and, [isResume, !isRunning])
            .clipShape(RoundedRectangle(cornerRadius: Size.routeCornerRadius))
            .padding(.horizontal, Size.routePadding)
    }
    
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
                    isResume = false
                    stopRecord()
                }
        }
    }
    
    private var resumeButton: some View {
        Toggle(Content.Label.empty, isOn: $isRunning)
            .onChange(of: isRunning) {
                isResume = true
                $0 ? startRecord() : pauseRecord()
            }
            .toggleStyle(IconStyle(onImage: Content.Image.play,
                                   offImage: Content.Image.pause, size: Size.stopWatchImage))
    }
    
    private func recordLabelView(
        spacing: CGFloat = Size.defaultVerticalSpacing,
        font: Font = .system(size: Size.labelFont, weight: .bold),
        label: String,
        bidingText: String)
    -> some View
    {
        VStack(spacing: spacing) {
            Text(bidingText).font(font)
            Text(label).asLabelStyle()
        }
    }
}

// MARK: Private Methods

extension RunningRecordView {
    private func bindViewModel() {
        recordVm.$isFinished
            .sink {
                guard $0 else { return }
                self.dismiss()
            }
            .store(in: &recordVm.cancelBag)

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

struct RunningRecordView_Previews: PreviewProvider {
    static var previews: some View {
        RunningRecordView(recordVm: DependencyContainer.previewRecordScene,
                          routeVm: DependencyContainer.previewRouteScene)
    }
}
