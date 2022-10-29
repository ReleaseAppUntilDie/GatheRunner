//
//  RunGuideDetailDescriptionView.swift
//  GatheRunner
//
//  Created by cho on 2022/10/13.
//

import SwiftUI

// MARK: - RunGuideDetailDescriptionView

struct RunGuideDescriptionView: View {
    
    // MARK: Internal
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundImage
            workoutTitle
            bottomViewContents
        }
        .overlay(alignment: .topTrailing) {
            closeButton
                .padding(Size.edgeInsetsOfCloseButton)
                .onTapGesture {
                    selectedItem = nil
                    yAxisOffsetOfViews = CGFloat(Size.backgroundImageAndGradientOffset) * -2
                }
        }
        .onChange(of: isPressed) { _ in
            savePreviousOffset()
        }
        .ignoresSafeArea()
        .gesture(dragGesture)
    }
    
    // MARK: Private
    
    @State private var yAxisOffsetOfViews: CGFloat = .zero
    @State private var yAxisOffsetOfDragGesture: CGFloat = .zero
    @State private var previousValueYAxisOffsetOfViews: CGFloat = .zero
    @State private var previousValueYAxisPositionOfBottomView: CGFloat = .zero
    @State private var minYPositionOfBottomView: CGFloat = .zero
    @State private var maxYPositionOfBottomView: CGFloat = .zero
    @State private var isPressed = false
    @Binding var selectedItem: RunGuideItem?
    let item: RunGuideItem
}

extension RunGuideDescriptionView {
    
    // MARK: Internal
    
    var backgroundImage: some View {
        Image(item.image)
            .offset(y: yAxisOffsetOfViews * Size.offsetReducer +  CGFloat(Size.backgroundImageAndGradientOffset))
            .frame(width: UIScreen.getWidthby(ratio: 1), height: UIScreen.getHeightby(ratio: 1))

    }
    
    var workoutTitle: some View {
        VStack(alignment: .leading) {
            Text(item.title)
            Text(item.subtitle).font(.largeTitle)
        }
        .font(.system(size: 40, weight: .heavy)).foregroundColor(.white)
        .padding(Size.edgeInsetsOfTitleTextView)
        .opacity(Double(1 + (yAxisOffsetOfViews / 800)))
        .offset(y: CGFloat(yAxisOffsetOfViews / 13))
    }
    
    @ViewBuilder
    var bottomViewContents: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { proxy in
                let _ = getMinYOfBottomView(proxy)
                let _ = getMaxYOfBottomView(proxy)
                makeBackgroundOfBottomView
            }
            VStack(alignment: .leading) {
                textViewSetForBottomView(Title.workoutGoal, item.workoutGoal)
                textViewSetForBottomView(Title.runningComposition, item.workoutComposition)
            }
            .overlay(alignment: .top) {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(100, corners: .allCorners).frame(width: 70, height: 5)
                    .padding(.top, 25)
                    .position(x: UIScreen.getWidthby(ratio: 0.5))
                    .zIndex(3)
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
            .padding(Size.edgeInsetsOfContentTextView)
        Text("\(contents)")
            .font(.headline)
            .foregroundColor(.gray)
            .padding(.horizontal, 30)
    }
}

extension RunGuideDescriptionView {
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
        ? yAxisOffsetOfViews = -UIScreen.screenHeight * 0.81
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
    
    private func getMinYOfBottomView(_ proxy: GeometryProxy) {
        DispatchQueue.main.async {
            minYPositionOfBottomView = proxy.frame(in: .global).minY - Size.workoutTitleOffset
        }
    }
}

extension RunGuideDescriptionView {
    private var dragGesture: some Gesture {
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
            }
    }
}

extension RunGuideDescriptionView {
    private enum Size {
        static let offsetReducer: CGFloat = 0.4
        static let backgroundImageAndGradientOffset = -120
        static let edgeInsetsOfCloseButton = EdgeInsets(top: UIScreen.screenHeight * 0.055, leading: 0, bottom: 0, trailing: 30)
        static let edgeInsetsOfTitleTextView = EdgeInsets(top: UIScreen.screenHeight * 0.11, leading: 30, bottom: 10, trailing: 30)
        static let edgeInsetsOfContentTextView = EdgeInsets(top: UIScreen.screenHeight * 0.071, leading: 30, bottom: 10, trailing: 30)
        static let symbolFontSize: CGFloat = 17
        static let symbolPaddingSize: CGFloat = 10
        static let opacityOfBackgroundImage = 0.6
        static let workoutTitleOffset: CGFloat = 50
    }
    
    private enum Title {
        static let workoutGoal = "워크아웃 목표"
        static let runningComposition = "러닝 구성"
    }
}

struct RunGuideDescriptionView_Previews: PreviewProvider {
    static let runGuideItem: RunGuideItem? = RunGuideViewModel().getArrsRunGuideExperienceItem[0]
    static let item = RunGuideViewModel().getArrsRunGuideExperienceItem[0]
    
    static var previews: some View {
        RunGuideDescriptionView(selectedItem: .constant(runGuideItem), item: item)
    }
}
