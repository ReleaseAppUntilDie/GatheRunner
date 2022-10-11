//
//  RunningGuideView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

// MARK: - RunningGuideView

struct RunningGuideView: View {

    // MARK: Internal

    @State var selectedCardItem: RunGuideItem? = nil

    var body: some View {
        ScrollView(showsIndicators: false) {
            cardItem
        }
    }

    var cardItem: some View {
        ForEach(runGuideCardItemArrs) { item in
            ZStack(alignment: .center) {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(cardItemCornerRadiusValue)
                    .shadow(radius: 2)
                VStack(alignment: .center) {
                    Text(item.title)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text(item.subtitle)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .cornerRadius(cardItemCornerRadiusValue)
            }
            .frame(width: UIScreen.getWidthby(ratio: cardItemFrameSizeRatio))
            .padding(.bottom, 20)
            .onTapGesture {
                withAnimation {
                    selectedCardItem = item
                }
            }
            .fullScreenCover(item: $selectedCardItem) { item in
                FullScreenCoverView(item: item)
            }
        }
    }

    // MARK: Private

    private let cardItemFrameSizeRatio = 0.89
    private let cardItemCornerRadiusValue: CGFloat = 20
    private let runGuideCardItemArrs = RunGuideViewModel().getArrsRunGuideExperienceItem
}

// MARK: - FullScreenCoverView

struct FullScreenCoverView: View {
    @Environment(\.dismiss) private var dismiss
    let item: RunGuideItem
    @State private var viewPositionYAxisOffset: CGFloat = .zero
    @State private var yAxisOffset: CGFloat = .zero
    @State private var previousYAxisPositionOfView: CGFloat = .zero
    @State private var previousYAxisPositionOfRunGuideBottomDescriptionView: CGFloat = .zero
    @State private var isPressed = false
    @State private var runGuideBottomDescriptionViewGlobalYAxisPosition: CGFloat = .zero
    private let reducerYAxisOffset: CGFloat = 0.4

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    CloseButton()
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 30))
                        .onTapGesture {
                            dismiss()
                        }
                }
                Spacer()
            }.zIndex(3)
            Image(item.image)
                .offset(y: viewPositionYAxisOffset * reducerYAxisOffset)
                .frame(width: UIScreen.getWidthby(ratio: 1), height: UIScreen.getHeightby(ratio: 1))
            runGuideBottomView
                .position(x: UIScreen.getWidthby(ratio: 0.5), y: UIScreen.getHeightby(ratio: 1.3))
                .offset(y: viewPositionYAxisOffset)
        }
        // MARK: 스크롤 구현을 위해 isPressed 프로퍼티 값 변경시 뷰 포지션의 정보값을 저장하도록함
        .onChange(of: isPressed) { _ in
            previousYAxisPositionOfView = viewPositionYAxisOffset
            previousYAxisPositionOfRunGuideBottomDescriptionView =
                runGuideBottomDescriptionViewGlobalYAxisPosition
        }
        .ignoresSafeArea()
        .gesture(
            DragGesture(minimumDistance: .leastNormalMagnitude)
                .onChanged { state in
                    withAnimation(.easeOut(duration: 1)) {
                        isPressed = true
                        setForCardItemOverlayYAxisPosition(state)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        isPressed = false
                        viewPositionYAxisOffset > CGFloat(-50) ? viewPositionYAxisOffset = 0 : nil
                        runGuideBottomDescriptionViewGlobalYAxisPosition - UIScreen.screenHeight < CGFloat(100)
                            ? viewPositionYAxisOffset = -UIScreen.screenHeight * 0.8
                            : nil
                    }
                })
    }
}

extension FullScreenCoverView {
    private var runGuideBottomView: some View {
        GeometryReader { proxy in
            getForRunGuideBottomDescriptionView(proxy)
            Rectangle()
                .frame(width: UIScreen.getWidthby(ratio: 1), height: UIScreen.getHeightby(ratio: 1.05))
            VStack(alignment: .leading) {
                TextViewSetForRunGuideBottomView(
                    title: "워크아웃 목표", contents: "\(item.workoutGoal)")
                TextViewSetForRunGuideBottomView(
                    title: "러닝 구성", contents: "\(item.workoutComposition)")
            }
        }
    }


    private func setForCardItemOverlayYAxisPosition(_ state: DragGesture.Value) {
        yAxisOffset = -state.translation.height * 1.5

        if
            previousYAxisPositionOfRunGuideBottomDescriptionView - yAxisOffset > UIScreen.screenHeight,
            previousYAxisPositionOfView - yAxisOffset < 0
        {
            viewPositionYAxisOffset = previousYAxisPositionOfView - yAxisOffset
        }
    }

    private func getForRunGuideBottomDescriptionView(_ proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            runGuideBottomDescriptionViewGlobalYAxisPosition = proxy.frame(in: .global).maxY
        }
        return EmptyView()
    }
}

// MARK: - TextViewSetForRunGuideBottomView

struct TextViewSetForRunGuideBottomView: View {
    let title: String
    let contents: String
    private let paddingBottomEdgeValueForRunGuideBottomView: CGFloat = 10
    private let paddingTheRestEdgeValueForRunGuideBottomView: CGFloat = 30

    var body: some View {
        Text("\(title)")
            .font(.title)
            .foregroundColor(.white)
            .padding(EdgeInsets(
                top: paddingTheRestEdgeValueForRunGuideBottomView,
                leading: paddingTheRestEdgeValueForRunGuideBottomView,
                bottom: paddingBottomEdgeValueForRunGuideBottomView,
                trailing: paddingTheRestEdgeValueForRunGuideBottomView))
        Text("\(contents)")
            .font(.headline)
            .foregroundColor(.gray)
            .padding(.horizontal, paddingTheRestEdgeValueForRunGuideBottomView)
    }
}

// MARK: - CloseButton

struct CloseButton: View {
    private let symbolFontSize: CGFloat = 17
    private let symbolPaddingValue: CGFloat = 10
    private let backgroundBlackOpacity = 0.6

    var body: some View {
        Image(systemName: "xmark")
            .font(.system(size: symbolFontSize, weight: .bold))
            .foregroundColor(.white)
            .padding(.all, symbolPaddingValue)
            .background(.black.opacity(backgroundBlackOpacity))
            .clipShape(Circle())
    }
}

// MARK: - RunningGuideView_Previews

struct RunningGuideView_Previews: PreviewProvider {
    static var previews: some View {
        RunningGuideView()
    }
}
