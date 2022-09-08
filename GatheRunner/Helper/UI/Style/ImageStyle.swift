//
//  ImageStyle.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/08.
//

import SwiftUI

extension Image {
    func asIconStyle(withMaxWidth maxWidth: CGFloat = 20, withMaxHeight maxHeigh: CGFloat = 20) -> some View {
        resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: maxWidth, height: maxHeigh)
            .foregroundColor(.white)
    }
}
