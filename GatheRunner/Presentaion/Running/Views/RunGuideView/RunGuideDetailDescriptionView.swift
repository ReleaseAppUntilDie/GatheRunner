//
//  RunGuideDetailDescriptionView.swift
//  GatheRunner
//
//  Created by cho on 2022/10/13.
//

import SwiftUI

// MARK: - RunGuideDetailDescriptionView

struct RunGuideDetailDescriptionView: View {

    // MARK: Internal

    var body: some View {
        ZStack {
            backgroundImage
            bottomViewContents
        }
        .overlay(alignment: .topTrailing) {
            closeButton
                .padding(Size.edgeInsetsOfCloseButton)
                .onTapGesture {
                    selectedItem = nil
                    yAxisOffsetOfViews = 0
                }
        }
        .onChange(of: isPressed) { _ in savePreviousOffset() }
        .ignoresSafeArea()
        .gesture(
            DragGesture(minimumDistance: .leastNormalMagnitude)
                .onChanged { state in
                    withAnimation(.easeOut(duration: 1)) {
                        dragGestureOnChangedEvent(state)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        dragGestureOnEndedEvent()
                    }
                })
    }

    // MARK: Private

    @State private var yAxisOffsetOfViews: CGFloat = .zero
    @State private var yAxisOffsetOfDragGesture: CGFloat = .zero
    @State private var previousValueYAxisOffsetOfViews: CGFloat = .zero
    @State private var previousValueYAxisPositionOfBottomView: CGFloat = .zero
    @State private var maxYPositionOfBottomView: CGFloat = .zero
    @State private var isPressed = false
    @Binding var selectedItem: RunGuideItem?
    let item: RunGuideItem
}

extension RunGuideDetailDescriptionView {

    // MARK: Internal

    var backgroundImage: some View {
        Image(item.image)
            .offset(y: yAxisOffsetOfViews * Size.offsetReducer)
            .frame(width: UIScreen.getWidthby(ratio: 1), height: UIScreen.getHeightby(ratio: 1))
    }

    @ViewBuilder
    var bottomViewContents: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { proxy in
                let _ = getMaxYOfBottomView(proxy)
                makeBackgroundOfBottomView
            }
            VStack(alignment: .leading) {
                textViewSetForBottomView(Title.workoutGoal, item.workoutGoal)
                textViewSetForBottomView(Title.runningComposition, item.workoutComposition)
            }
        }
        .position(x: UIScreen.getWidthby(ratio: 0.5), y: UIScreen.getHeightby(ratio: 1.3))
        .offset(y: yAxisOffsetOfViews)
    }

    var closeButton: some View {
        Image(systemName: "xmark")
            .font(.system(size: Size.symbolFontSize, weight: .bold))
            .foregroundColor(.white)
            .padding(.all, Size.symbolPaddingSize)
            .background(.black.opacity(Size.opacityOfBackgroundImage))
            .clipShape(Circle())
    }

    // MARK: Private

    private var makeBackgroundOfBottomView: some View {
        Rectangle().frame(width: UIScreen.getWidthby(ratio: 1), height: UIScreen.getHeightby(ratio: 1.05))
    }
    
    @ViewBuilder
    private func textViewSetForBottomView(_ title: String, _ contents: String) -> some View {
        Text("\(title)")
            .font(.title)
            .foregroundColor(.white)
            .padding(Size.edgeInsetsOfTextView)
        Text("\(contents)")
            .font(.headline)
            .foregroundColor(.gray)
            .padding(.horizontal, 30)
    }
}

extension RunGuideDetailDescriptionView {
    private func savePreviousOffset() {
        previousValueYAxisOffsetOfViews = yAxisOffsetOfViews
        previousValueYAxisPositionOfBottomView =
            maxYPositionOfBottomView
    }

    private func dragGestureOnChangedEvent(_ state: DragGesture.Value) {
        isPressed = true
        setYAxisOffsetOfViews(state)
    }

    private func dragGestureOnEndedEvent() {
        isPressed = false
        yAxisOffsetOfViews > CGFloat(-50) ? yAxisOffsetOfViews = 0 : nil
        maxYPositionOfBottomView - UIScreen.screenHeight < CGFloat(100)
            ? yAxisOffsetOfViews = -UIScreen.screenHeight * 0.8
            : nil
    }

    private func setYAxisOffsetOfViews(_ state: DragGesture.Value) {
        yAxisOffsetOfDragGesture = -state.translation.height * 1.5

        if
            previousValueYAxisPositionOfBottomView - yAxisOffsetOfDragGesture > UIScreen.screenHeight,
            previousValueYAxisOffsetOfViews - yAxisOffsetOfDragGesture < 0
        {
            yAxisOffsetOfViews = previousValueYAxisOffsetOfViews - yAxisOffsetOfDragGesture
        }
    }

    private func getMaxYOfBottomView(_ proxy: GeometryProxy) {
        DispatchQueue.main.async {
            maxYPositionOfBottomView = proxy.frame(in: .global).maxY
        }
    }
}

extension RunGuideDetailDescriptionView {
    private enum Size {
        static let offsetReducer: CGFloat = 0.4
        static let edgeInsetsOfCloseButton = EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 30)
        static let edgeInsetsOfTextView = EdgeInsets(top: 30, leading: 30, bottom: 10, trailing: 30)
        static let symbolFontSize: CGFloat = 17
        static let symbolPaddingSize: CGFloat = 10
        static let opacityOfBackgroundImage = 0.6
    }

    private enum Title {
        static let workoutGoal = "워크아웃 목표"
        static let runningComposition = "러닝 구성"
    }
}
