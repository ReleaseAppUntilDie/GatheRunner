//
//  RunGuideExpItem.swift
//  GatheRunner
//
//  Created by cho on 2022/07/10.
//

import SwiftUI

struct RunGuideItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let subtitle: String
    let contents: String
    let workoutGoal: String
    let workoutComposition: String
}
