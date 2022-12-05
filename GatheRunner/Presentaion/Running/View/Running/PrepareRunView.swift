//
//  PrepareRunView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

// MARK: - PrepareRunView

struct PrepareRunView: View {
    var body: some View {
        ZStack {
            MapView(viewModel: DependencyContainer.previewMapScene).hide(isPresentedRunGuideDetailDescriptionView)
            VStack {
                workoutIndexView.didSetLoadable(by: $viewModel.fetchStatus)
                RunGuideTabView(isPresentedRunGuideDetailDescriptionView: $isPresentedRunGuideDetailDescriptionView).padding(0)
                Spacer()
                startButton.padding(.bottom, Size.Start.padding)
            }
        }
    }
    
    // MARK: - NameSpace

    private enum Size {
        static let workoutIndexTextKerning: CGFloat = 2.0
        static let workoutIndexTextLineSpacing: CGFloat = 4.0
        static let workoutIndexTextFontSize: CGFloat = 13
        
        enum Start {
            static let widthRatio = 0.2820
            static let heightRatio = 0.1303
            static let fontSize: CGFloat = 27
            static let imageRadius: CGFloat = 200
            static let padding: CGFloat = 20
        }
    }
    
    private enum Label {
        enum Start {
            static let title = "시작"
        }
    }
    
    // MARK: Properties

    @EnvironmentObject var container: DependencyContainer
    @StateObject var viewModel: PrepareRunViewModel
    
    @State private var isPresentedRunGuideDetailDescriptionView = false
    @State private var isRunning = false
}

// MARK: - SubViews

extension PrepareRunView {
    private var workoutIndexView: some View {
        Rectangle()
            .frame(height: UIScreen.getHeightby(ratio: 0.03))
            .foregroundColor(.white)
            .overlay {
                Text(viewModel.todayInfo)
                    .bold()
                    .kerning(Size.workoutIndexTextKerning)
                    .lineSpacing(Size.workoutIndexTextLineSpacing)
                    .font(.system(size: Size.workoutIndexTextFontSize))
            }
    }
    
    private var startButton: some View {
        NavigationLink(destination: runningRecord, isActive: $isRunning) {
            startImage
        }
    }
    
    private var startImage: some View {
        Circle()
            .frame(
                width: UIScreen.getWidthby(ratio: Size.Start.widthRatio),
                height: UIScreen.getHeightby(ratio: Size.Start.heightRatio))
            .overlay { startTitle }
            .foregroundColor(.yellow)
            .cornerRadius(Size.Start.imageRadius)
    }
    
    private var startTitle: some View {
        Text(Label.Start.title)
            .font(.system(size: Size.Start.fontSize, weight: .black))
            .foregroundColor(Color.black)
    }
    
    private var runningRecord: some View {
        RunningRecordView(
            isRunning: $isRunning,
            recordVm: container.viewModels.recordVm,
            routeVm: container.viewModels.routeVm)
    }
}

// MARK: - JustStartView_Previews

struct PrepareRunView_Previews: PreviewProvider {
    static var previews: some View {
        PrepareRunView(viewModel: DependencyContainer.previewPrepareScene)
    }
}
