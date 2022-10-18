//
//  FloatingView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/12.
//

import SwiftUI

// MARK: - BottomButtonsView

struct BottomButtonsView: View {

    // MARK: - 측정화면으로 이동을 위한 임시 구현

    @State var tag: Int? = nil

    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center, spacing: 30) {
                SideBtn(iconName: .goalSetting)
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
                SideBtn(iconName: .music)
            }
        }
    }
}

// MARK: - StartBtn

struct StartBtn: View {
    private let startBtnWidthRatio = 0.2820
    private let startBtnHeightRatio = 0.1303
    private let startBtnFontSize: CGFloat = 27
    @Binding var tag: Int?

    var body: some View {
        Button("시작") {
            self.tag = 1
        }
        .frame(
            width: UIScreen.getWidthby(ratio: startBtnWidthRatio),
            height: UIScreen.getHeightby(ratio: startBtnHeightRatio))
        .background(Color.yellow)
        .font(.system(size: startBtnFontSize, weight: .black)).foregroundColor(Color.black)
        .cornerRadius(200)
        .accessibilityIdentifier("runStartButton")
    }
}

// MARK: - SideBtn

struct SideBtn: View {
    fileprivate var iconName: BtnName
    private let sideBtnWidthRatio = 0.1154
    private let sideBtnHeightRatio = 0.0592
    private let symbolFontSize: CGFloat = 25
    private let cornerRadiusValue: CGFloat = 200

    var body: some View {
        Button { } label: {
            Image(systemName: selectIcon(iconName))
                .frame(
                    width: UIScreen.getWidthby(ratio: sideBtnWidthRatio),
                    height: UIScreen.getHeightby(ratio: sideBtnHeightRatio))
                .font(.system(size: symbolFontSize)).foregroundColor(Color.black)
                .background(Color.white)
                .cornerRadius(cornerRadiusValue)
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
