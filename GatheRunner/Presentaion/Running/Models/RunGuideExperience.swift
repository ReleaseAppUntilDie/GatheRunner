//
//  RunGuideExpItem.swift
//  GatheRunner
//
//  Created by cho on 2022/07/10.
//

import SwiftUI

struct RunGuideExperienceItem: Identifiable {
    let id = UUID()
    var image: String
    var title: String
    var subtitle: String
    var text: String
    var tag: Int
}
