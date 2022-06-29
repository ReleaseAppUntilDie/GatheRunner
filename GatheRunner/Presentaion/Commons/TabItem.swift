//
//  TabItem.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

struct TabItem: Identifiable {
    let view: AnyView
    let id = UUID()
    let title: Text
    let icon: Image
    let tag: Int
}
