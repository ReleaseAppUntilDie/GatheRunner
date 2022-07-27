//
//  MenuBarButton.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/07/27.
//

import SwiftUI

//MARK: - 사용예시: MenuBarButton(color: .black, size: 30, image: Image(systemName: "person.crop.circle.fill")) { rightButtonAction() }

struct MenuBarButton: View {
    let color: Color
    let size: CGFloat
    let image: Image
    let action: () -> Void
        
    var body: some View {
        Button { action()
        } label: {
            image.asButtonIconStyle(size: size, foregroundColor: color)
        }
    }
}
