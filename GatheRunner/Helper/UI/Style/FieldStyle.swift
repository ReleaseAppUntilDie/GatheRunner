//
//  FieldStyle.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/18.
//

import SwiftUI

// MARK: - ValidationFieldModifier

struct ValidationFieldModifier: ViewModifier {
    @FocusState private var isFocused: Bool
    @Binding var isValid: Bool
    @State private var borderColor: Color = .gray
    var cornerRadius: CGFloat
    var lineWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .onSubmit { validated() }
            .submitLabel(.done)
            .focused($isFocused)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(borderColor, lineWidth: 1))
    }

    private func validated() {
        if isValid {
            borderColor = .blue
        } else {
            borderColor = .red
        }
    }
}

extension View {
    @ViewBuilder
    func asValidationFieldStyle(
        isValid: Binding<Bool>,
        withCornerRadius cornerRadius: CGFloat = 8,
        withLineWidth lineWidth: CGFloat = 1)
        -> some View
    {
        modifier(ValidationFieldModifier(isValid: isValid, cornerRadius: cornerRadius, lineWidth: lineWidth))
    }

}
