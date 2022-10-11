//
//  EmptyActivityView.swift
//  GatheRunner
//
//  Created by 김현진 on 2022/08/24.
//

import SwiftUI

// MARK: - EmptyActivityView

struct EmptyActivityView: View {
    var body: some View {
        VStack {
            Image("EmptyActivityIcon")
                .padding(.bottom)
            Text("달리기를 시작하세요")
                .frame(
                    width: UIScreen.getWidthby(ratio: 0.9),
                    alignment: .leading)
                .font(.system(
                    size: 30,
                    weight: .semibold))
                .padding(.bottom)
            Text("페이스는 신경쓰지 말고 달리세요. Gatherunner 와 달리면 이 화면에서 기록과 성과를 확인하실 수 있습니다.")
                .frame(
                    width: UIScreen.getWidthby(ratio: 0.9),
                    alignment: .leading)
                .multilineTextAlignment(.leading)
                .foregroundColor(.init(uiColor: .systemGray2))
                .padding(.bottom)
            Text("기록을 남겨 보세요!")
                .frame(
                    width: UIScreen.getWidthby(ratio: 0.9),
                    alignment: .leading)
                .foregroundColor(.init(uiColor: .systemGray2))
            Spacer()
            Button {
                SelectedTab.shared.index = TabItem.MainComponent.run.tag
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: UIScreen.getHeightby(ratio: 0.03))
                        .frame(width: UIScreen.getWidthby(ratio: 0.9), height: UIScreen.getHeightby(ratio: 0.06))
                        .foregroundColor(.black)

                    Text("달리러 가기")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .medium))
                }.padding(.bottom)
            }
        }
    }
}

// MARK: - EmptyActivityView_Previews

struct EmptyActivityView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyActivityView()
    }
}
