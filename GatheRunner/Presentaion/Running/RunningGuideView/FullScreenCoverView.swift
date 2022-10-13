//
//  FullScreenCoverView.swift
//  GatheRunner
//
//  Created by cho on 2022/10/13.
//

import SwiftUI

// MARK: - FullScreenCoverView

struct FullScreenCoverView: View {
    
    // MARK: Internal
    
    var body: some View {
        ZStack {
            backgroundImage
            fullScreenCoverViewBottomContents
        }
        .overlay(CloseButton()
            .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 30)), alignment: .topTrailing)
            .onTapGesture {
                dismiss()
            }
        .onChange(of: isPressed) { _ in
            isPressedEvent()
        }
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
    
    private var fullScreenCoverViewBottomContents: some View {
        GeometryReader { proxy in
            let _ = getBottomDescriptionMaxYPosition(proxy)
            Rectangle()
                .frame(width: UIScreen.getWidthby(ratio: 1), height: UIScreen.getHeightby(ratio: 1.05))
            VStack(alignment: .leading) {
                TextViewSetForRunGuideBottomView(
                    title: "워크아웃 목표", contents: "\(item.workoutGoal)")
                TextViewSetForRunGuideBottomView(
                    title: "러닝 구성", contents: "\(item.workoutComposition)")
            }
        }
        .position(x: UIScreen.getWidthby(ratio: 0.5), y: UIScreen.getHeightby(ratio: 1.3))
        .offset(y: viewPositionYAxisOffset)
    }
    
    private var backgroundImage: some View {
        Image(item.image)
            .offset(y: viewPositionYAxisOffset * Size.reducerYAxisOffset)
            .frame(width: UIScreen.getWidthby(ratio: 1), height: UIScreen.getHeightby(ratio: 1))
    }
    
    // MARK: Private

    @Environment(\.dismiss) private var dismiss
    @State private var viewPositionYAxisOffset: CGFloat = .zero
    @State private var yAxisOffset: CGFloat = .zero
    @State private var previousValueYAxisOffset: CGFloat = .zero
    @State private var previousYAxisPositionOfBottomDescription: CGFloat = .zero
    @State private var isPressed = false
    @State private var bottomDescriptionMaxYPosition: CGFloat = .zero
    let item: RunGuideItem
}

extension FullScreenCoverView {
    private enum Size {
        static let reducerYAxisOffset: CGFloat = 0.4
    }
}

extension FullScreenCoverView {
    private func isPressedEvent() {
        previousValueYAxisOffset = viewPositionYAxisOffset
        previousYAxisPositionOfBottomDescription =
        bottomDescriptionMaxYPosition
    }
    
    private func dragGestureOnChangedEvent(_ state: DragGesture.Value) {
        isPressed = true
        setForCardItemOverlayYAxisPosition(state)
    }
    
    private func dragGestureOnEndedEvent() {
        isPressed = false
        viewPositionYAxisOffset > CGFloat(-50) ? viewPositionYAxisOffset = 0 : nil
        bottomDescriptionMaxYPosition - UIScreen.screenHeight < CGFloat(100)
        ? viewPositionYAxisOffset = -UIScreen.screenHeight * 0.8
        : nil
    }
}

extension FullScreenCoverView {
    private func setForCardItemOverlayYAxisPosition(_ state: DragGesture.Value) {
        yAxisOffset = -state.translation.height * 1.5
        
        if
            previousYAxisPositionOfBottomDescription - yAxisOffset > UIScreen.screenHeight,
            previousValueYAxisOffset - yAxisOffset < 0
        {
            viewPositionYAxisOffset = previousValueYAxisOffset - yAxisOffset
        }
    }
    
    private func getBottomDescriptionMaxYPosition(_ proxy: GeometryProxy) {
        DispatchQueue.main.async {
            bottomDescriptionMaxYPosition = proxy.frame(in: .global).maxY
        }
    }
}

// MARK: - TextViewSetForRunGuideBottomView

struct TextViewSetForRunGuideBottomView: View {
    let title: String
    let contents: String
    
    var body: some View {
        Text("\(title)")
            .font(.title)
            .foregroundColor(.white)
            .padding(EdgeInsets(
                top: Size.paddingValueTheRestEdgeForRunGuideBottomView,
                leading: Size.paddingValueTheRestEdgeForRunGuideBottomView,
                bottom: Size.paddingValueBottomEdgeForRunGuideBottomView,
                trailing: Size.paddingValueTheRestEdgeForRunGuideBottomView))
        Text("\(contents)")
            .font(.headline)
            .foregroundColor(.gray)
            .padding(.horizontal, Size.paddingValueTheRestEdgeForRunGuideBottomView)
    }
}

extension TextViewSetForRunGuideBottomView {
    private enum Size {
        static let reducerYAxisOffset: CGFloat = 0.4
        static let paddingValueBottomEdgeForRunGuideBottomView: CGFloat = 10
        static let paddingValueTheRestEdgeForRunGuideBottomView: CGFloat = 30
    }
}
// MARK: - CloseButton

struct CloseButton: View {
    
    // MARK: Internal
    
    var body: some View {
        Image(systemName: "xmark")
            .font(.system(size: Size.symbolFontSize, weight: .bold))
            .foregroundColor(.white)
            .padding(.all, Size.symbolPaddingValue)
            .background(.black.opacity(Opacity.backgroundBlackOpacity))
            .clipShape(Circle())
    }
}

extension CloseButton {
    private enum Size {
        static let symbolFontSize: CGFloat = 17
        static let symbolPaddingValue: CGFloat = 10
    }
    
    private enum Opacity {
        static let backgroundBlackOpacity = 0.6
    }
}
