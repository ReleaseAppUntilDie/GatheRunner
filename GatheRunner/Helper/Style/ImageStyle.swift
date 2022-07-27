//
//  ImageStyle.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/07/27.
//

import SwiftUI

extension Image {
    func asButtonIconStyle(size: CGFloat, foregroundColor: Color) -> some View {
        
        self.resizable()
            .renderingMode(.template)
            .foregroundColor(foregroundColor)
            .frame(width: size, height: size)
    }
}
