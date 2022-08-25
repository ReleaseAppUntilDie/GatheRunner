//
//  TextStyle.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/07/07.
//

import SwiftUI

// MARK: - Timer Text Style

extension Text {
    func asTimerStyle(fontSize: CGFloat = 200, color: Color = .green) -> some View {
        font(.system(size: fontSize)).bold()
            .foregroundColor(color)
    }
}

extension Text {
    func asLabelStyle(fontSize: CGFloat = 20, fontWeight: Font.Weight = .light, color: Color = .gray) -> some View {
        font(.system(size: fontSize, weight: fontWeight))
            .foregroundColor(color)
    }
}
