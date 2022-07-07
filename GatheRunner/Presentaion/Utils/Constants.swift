//
//  Constants.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/07/07.
//

import SwiftUI


struct ScreenSize {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static func getWidth(_ width : Double) -> Double {
        return screenWidth * (width/375)
    }
    
    static func getHeight(_ height : Double) -> Double {
        return screenHeight * (height/812)
    }
    static func getHeightby(ratio : Double) -> Double {
        return screenHeight * ratio
    }
    
    static func getWidthby(ratio : Double) -> Double {
        return screenWidth * ratio
    }

}
