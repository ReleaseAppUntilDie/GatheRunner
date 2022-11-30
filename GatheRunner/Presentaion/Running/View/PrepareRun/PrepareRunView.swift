//
//  PrepareRunView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

// MARK: - PrepareRunView

struct PrepareRunView: View {
    @State private var isPresentedRunGuideDetailDescriptionView = false
    @StateObject var viewModel: PrepareRunViewModel = PrepareRunViewModel()

    var body: some View {
        ZStack {
            MapView().hide(isPresentedRunGuideDetailDescriptionView)
            VStack {
                workoutIndexView
                RunGuideTabView(isPresentedRunGuideDetailDescriptionView: $isPresentedRunGuideDetailDescriptionView).padding(0)
                Spacer()
                BottomButtonView().padding(.bottom, 30)
            }
        }.onAppear {
            viewModel.getWorkoutIndex()
        }
    }
}

extension PrepareRunView {
    private var workoutIndexView: some View {
        Rectangle()
            .frame(height: UIScreen.getHeightby(ratio: 0.03))
            .foregroundColor(.white)
            .overlay {
                Text(viewModel.getWorkoutIndexContents())
                    .bold()
                    .kerning(Size.workoutIndexTextKerning)
                    .lineSpacing(Size.workoutIndexTextLineSpacing)
                    .font(.system(size: Size.workoutIndexTextFontSize))
            }
    }
}

extension PrepareRunView {
    private enum Size {
        static let workoutIndexTextKerning: CGFloat = 2.0
        static let workoutIndexTextLineSpacing: CGFloat = 4.0
        static let workoutIndexTextFontSize: CGFloat = 13
    }
}

// MARK: - JustStartView_Previews

struct PrepareRunView_Previews: PreviewProvider {
    static var previews: some View {
        PrepareRunView()
    }
}
