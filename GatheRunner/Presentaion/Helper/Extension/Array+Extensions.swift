//
//  Array+Extensions.swift
//  GatheRunner
//
//  Created by cho on 2022/07/20.
//

import SwiftUI

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
