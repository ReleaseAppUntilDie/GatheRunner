//
//  Array+Safe.swift
//  GatheRunner
//
//  Created by cho on 2022/07/16.
//

import Foundation

// MARK: - Safe Array

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
