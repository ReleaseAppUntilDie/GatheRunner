//
//  BottomButtonView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/12.
//

import SwiftUI

// MARK: - BottomButtonView

struct BottomButtonView: View {
    @State var tag: Int? = nil

    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center, spacing: 30) {
                ZStack {
                    // MARK: - 측정화면으로 이동을 위한 임시 구현

                    NavigationLink(
                        destination: RunningRecordView().environmentObject(LocationManager()),
                        tag: 1,
                        selection: self.$tag)
                    {
                        EmptyView()
                    }
                    StartBtn(tag: $tag)
                }
            }
        }
    }
}

// MARK: - StartBtn

struct StartBtn: View {
    @Binding var tag: Int?
    @State private var isPressed: Bool = false

    var body: some View {
        Circle()
            .frame(
                width: UIScreen.getWidthby(ratio: Size.startBtnWidthRatio),
                height: UIScreen.getHeightby(ratio: Size.startBtnHeightRatio))
            .foregroundColor(isPressed ? .black.opacity(0.5) : .yellow)
            .overlay {
                Text("시작")
                    .font(.system(size: Size.startBtnFontSize, weight: .black))
                    .foregroundColor(Color.black)
            }
            .cornerRadius(200)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged( { _ in
                        isPressed = true
                    })
                    .onEnded( { _ in
                        isPressed = false
                        self.tag = 1
                    })
            
            )
            .accessibilityIdentifier("runStartButton")
    }
}

extension StartBtn {
    private enum Size {
        static let startBtnWidthRatio = 0.2820
        static let startBtnHeightRatio = 0.1303
        static let startBtnFontSize: CGFloat = 27
    }
}

// MARK: - FloatingView_Previews

struct FloatingView_Previews: PreviewProvider {
    static var previews: some View {
        BottomButtonView()
    }
}
