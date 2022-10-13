//
//  View+Extension.swift
//  GatheRunner
//
//  Created by cho on 2022/07/19.
//
import SwiftUI

// MARK: - RoundedCorner

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// MARK: - RoundedTopCorner

struct RoundedTopCorner: Shape {
    var radius: CGFloat = .infinity

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct Hide: ViewModifier {
    let isVisible: Bool

    @ViewBuilder
    func body(content: Content) -> some View {
        if isVisible {
            content
        } else {
            content.hidden()
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }

    func topCornerRadius(_ radius: CGFloat) -> some View {
        clipShape(RoundedTopCorner(radius: radius))
    }
    
    func hide(isVisible: Bool) -> some View {
        ModifiedContent(content: self, modifier: Hide(isVisible: isVisible))
    }
}
