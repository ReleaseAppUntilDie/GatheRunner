//
//  VerticalAlignment.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/07/29.
//

import SwiftUI

extension VerticalAlignment {
    struct CustomAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[VerticalAlignment.center]
        }
    }

    static let verticalCustom = VerticalAlignment(CustomAlignment.self)
}

extension HorizontalAlignment {
    struct CustomAlignment : AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[HorizontalAlignment.center]
        }
    }
    static let horizontalCustom = HorizontalAlignment(CustomAlignment.self)
}
