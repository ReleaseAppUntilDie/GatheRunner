//
//  View+onLongPressGestureWithAlert.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/08.
//

import SwiftUI

// MARK: - TapAndLongPressWithAlertModifier

struct TapAndLongPressWithAlertModifier: ViewModifier {
    @State var isAlertPresent = false

    let longPressAction: () -> Void
    let alertText: String
    let intervalTime: Double

    func body(content: Content) -> some View {
        content
            .onTapGesture {
                $isAlertPresent.wrappedValue = true
                Timer.scheduledTimer(withTimeInterval: intervalTime, repeats: false, block: { _ in
                    $isAlertPresent.wrappedValue = false
                })
            }
            .alert(isPresented: $isAlertPresent) {
                Alert(title: Text(alertText), message: .none, dismissButton: .none)
            }
            .onLongPressGesture(minimumDuration: 0.1) {
                longPressAction()
            }
    }
}

extension View {
    func tapAndLongPressWithAlert(
        longPressAction: @escaping () -> Void,
        alertText: String,
        intervalTime: Double = 0.5)
        -> some View
    {
        modifier(TapAndLongPressWithAlertModifier(
            longPressAction: longPressAction,
            alertText: alertText,
            intervalTime: intervalTime))
    }
}
