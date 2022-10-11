//
//  ActivityHistoryView.swift
//  GatheRunner
//
//  Created by 김현진 on 2022/08/24.
//

import SwiftUI

// MARK: - ActivityHistoryView

struct ActivityHistoryView: View {
    var body: some View {
        ScrollView {
            GraphView()
            HistoryList()
        }
    }
}

// MARK: - ActivityHistoryView_Previews

struct ActivityHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityHistoryView()
    }
}
