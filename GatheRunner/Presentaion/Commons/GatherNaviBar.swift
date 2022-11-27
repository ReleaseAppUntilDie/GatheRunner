//
//  GatherNavBar.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/08/14.
//

import SwiftUI

struct GatherNaviBar<Left, Center, Right>: View where Left: View, Center: View, Right: View {

    // MARK: Lifecycle

    init(
        @ViewBuilder left: @escaping () -> Left,
        @ViewBuilder center: @escaping () -> Center,
        @ViewBuilder right: @escaping () -> Right)
    {
        self.left = left
        self.center = center
        self.right = right
    }

    // MARK: Internal

    let left: () -> Left
    let center: () -> Center
    let right: () -> Right

    var body: some View {
        ZStack {
            HStack {
                left()
                Spacer()
            }
            center()
            HStack {
                Spacer()
                right()
            }
        }
    }
}
