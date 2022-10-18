//
//  LongPressTypeAlertModifier.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/08.
//

import SwiftUI

// MARK: - Constants

private enum Constants {
    fileprivate static let alertText = "길게 눌러주세요."
    fileprivate static let alertDuration: Double = 2
    fileprivate static let LongPressDuration = 0.5
}

// MARK: - LongPressTypeAlertModifier

struct LongPressTypeAlertModifier: ViewModifier {

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
    func addLongPressTypeAlert(
        withAction longPressAction: @escaping () -> Void,
        alertText: String = Constants.alertText,
        alertDuration: Double = Constants.alertDuration,
        LongPressDuration: Double = Constants.LongPressDuration)
        -> some View
    {
        modifier(LongPressTypeAlertModifier(
            longPressAction: longPressAction,
            alertText: alertText,
            alertDuration: alertDuration,
            LongPressDuration: LongPressDuration))
    }
}
