//
//  Toggle+IconStyle.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/18.
//

import SwiftUI

struct IconStyle: ToggleStyle {
    let onImage: String
    let offImage: String
    var size: CGFloat = 100

    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(configuration.isOn ? offImage : onImage)
                    .asIconStyle(withMaxWidth: size, withMaxHeight: size)
            }
        }
    }
}
