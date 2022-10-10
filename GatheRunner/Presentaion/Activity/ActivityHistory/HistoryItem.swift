//
//  HistoryItem.swift
//  GatheRunner
//
//  Created by 김현미 on 2022/10/10.
//

import SwiftUI

// MARK: - HistoryItem

struct HistoryItem: View {
    var body: some View {
        ZStack {
            Color.white
            Text("Running Item")
        }
        .frame(width: UIScreen.getWidthby(ratio: 0.8))
        .cornerRadius(20)
    }
}

// MARK: - HistoryItem_Previews

struct HistoryItem_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItem()
    }
}
