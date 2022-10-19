//
//  FieldStyle.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/18.
//

import SwiftUI

// MARK: - ValidationFieldModifier

struct ValidationFieldModifier: ViewModifier {
    fileprivate enum Size {
        static let cornerRadius: CGFloat = 8
        static let lineWidth: CGFloat = 1
    }

    @FocusState private var isFocused: Bool
    @Binding var isValid: Bool
    @State var borderColor: Color

    var cornerRadius: CGFloat
    var lineWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .onSubmit { borderColor = isValid ? .blue : .red }
            .submitLabel(.done)
            .focused($isFocused)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(borderColor, lineWidth: lineWidth))
    }
}

extension View {

    // MARK: Internal

    @ViewBuilder
    func asValidationFieldStyle(
        isValid: Binding<Bool>,
        witBorderColor borderColor: Color = .gray,
        withCornerRadius cornerRadius: CGFloat = DefaultSize.cornerRadius,
        withLineWidth lineWidth: CGFloat = DefaultSize.lineWidth)
        -> some View
    {
        modifier(ValidationFieldModifier(
            isValid: isValid,
            borderColor: borderColor,
            cornerRadius: cornerRadius,
            lineWidth: lineWidth))
    }

    // MARK: Fileprivate

    fileprivate typealias DefaultSize = ValidationFieldModifier.Size
}
