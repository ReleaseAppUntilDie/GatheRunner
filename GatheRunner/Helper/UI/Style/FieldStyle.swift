//
//  FieldStyle.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/18.
//

import SwiftUI

// MARK: - ValidationFieldModifier

struct ValidationFieldModifier: ViewModifier {
    private enum Size {
        static let cornerRadius: CGFloat = 8
        static let lineWidth: CGFloat = 1
    }

    @FocusState private var isFocused: Bool
    @Binding var isValid: Bool
    @State var borderColor: Color = .gray

    var cornerRadius: CGFloat = Size.cornerRadius
    var lineWidth: CGFloat = Size.lineWidth

    func body(content: Content) -> some View {
        content
            .onSubmit { didValidate() }
            .submitLabel(.done)
            .focused($isFocused)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(borderColor, lineWidth: lineWidth))
    }

    private func didValidate() {
        guard isValid else {
            borderColor = .red
            return
        }
        borderColor = .blue
    }
}

extension View {
    @ViewBuilder
    func asValidationFieldStyle(isValid: Binding<Bool>) -> some View {
        modifier(ValidationFieldModifier(isValid: isValid))
    }

    @ViewBuilder
    func asValidationFieldStyle(
        isValid: Binding<Bool>,
        witBorderColor borderColor: Color,
        withCornerRadius cornerRadius: CGFloat,
        withLineWidth lineWidth: CGFloat)
        -> some View
    {
        modifier(ValidationFieldModifier(
            isValid: isValid,
            borderColor: borderColor,
            cornerRadius: cornerRadius,
            lineWidth: lineWidth))
    }

}
