//
//  BottomButtonsView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/12.
//

import SwiftUI

// MARK: - BottomButtonsView

struct BottomButtonsView: View {
    @State var tag: Int? = nil

    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center, spacing: 30) {
                SideBtn(iconName: .goalSetting)
                ZStack {
                    // MARK: - 측정화면으로 이동을 위한 임시 구현

                    NavigationLink(
                        destination: MeasurementView().environmentObject(LocationManager()),
                        tag: 1,
                        selection: self.$tag)
                    {
                        EmptyView()
                    }
                    StartBtn(tag: $tag)
                }
                SideBtn(iconName: .music)
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

// MARK: - SideBtn

struct SideBtn: View {
    fileprivate var iconName: BtnName

    var body: some View {
        Button { } label: {
            Image(systemName: selectIcon(iconName))
                .frame(
                    width: UIScreen.getWidthby(ratio: Size.sideBtnWidthRatio),
                    height: UIScreen.getHeightby(ratio: Size.sideBtnHeightRatio))
                .font(.system(size: Size.symbolFontSize)).foregroundColor(Color.black)
                .background(Color.white)
                .cornerRadius(Size.cornerRadiusValue)
                .shadow(color: Color.gray, radius: 2, x: 3, y: 3)
        }
    }
}

extension SideBtn {

    // MARK: Internal

    enum BtnName {
        case goalSetting
        case music
    }

    // MARK: Private

    private enum Size {
        static let sideBtnWidthRatio = 0.1154
        static let sideBtnHeightRatio = 0.0592
        static let symbolFontSize: CGFloat = 25
        static let cornerRadiusValue: CGFloat = 200
    }

}

extension SideBtn {
    private func selectIcon(_ name: BtnName) -> String {
        switch name {
        case .goalSetting: return "gearshape.fill"
        case .music: return "music.note"
        }
    }
}

// MARK: - FloatingView_Previews

struct FloatingView_Previews: PreviewProvider {
    static var previews: some View {
        BottomButtonsView()
    }
}