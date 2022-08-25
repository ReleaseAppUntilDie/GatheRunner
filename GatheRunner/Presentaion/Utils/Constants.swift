//
//  Constants.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/07/07.
//

import SwiftUI


extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height


    static func getHeightby(ratio : Double) -> Double {
        screenHeight * ratio
    }

    static func getWidthby(ratio : Double) -> Double {
        screenWidth * ratio
    }
}

