//
//  AlertWhenTappedAndLongPressModifier.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/08.
//

import SwiftUI

// MARK: - AlertWhenTappedAndLongPressModifier

struct AlertWhenTappedAndLongPressModifier: ViewModifier {
    @State var isAlertPresent = false

    let longPressAction: () -> Void
    let alertText: String
    let alertDuration: Double
    let LongPressDuration: Double

    func body(content: Content) -> some View {
        content
            .onTapGesture {
                $isAlertPresent.wrappedValue = true
                Timer.scheduledTimer(withTimeInterval: alertDuration, repeats: false, block: { _ in
                    $isAlertPresent.wrappedValue = false
                })
            }
            .alert(isPresented: $isAlertPresent) {
                Alert(title: Text(alertText), message: .none, dismissButton: .none)
            }
            .onLongPressGesture(minimumDuration: LongPressDuration) {
                longPressAction()
            }
    }
}

extension View {
    func setAlertWhenTappedAndLongPress(
        withAction longPressAction: @escaping () -> Void,
        alertText: String,
        alertDuration: Double = 2,
        LongPressDuration: Double = 0.5)
        -> some View
    {
        modifier(AlertWhenTappedAndLongPressModifier(
            longPressAction: longPressAction,
            alertText: alertText,
            alertDuration: alertDuration,
            LongPressDuration: LongPressDuration))
    }
}
