//
//  ActivityView.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/08/24.
//

import SwiftUI

// MARK: - ActivityView

struct ActivityView: View {
    var body: some View {
        VStack {
            HeaderView(title: "활동",type: .activity) {}
            
            if !viewModel.historys.isEmpty {
                ActivityHistoryView(viewModel: viewModel)
            } else {
                EmptyActivityView()
            }
        }
        .didSetLoadable(by: $viewModel.fetchStatus)
        .ignoresSafeArea(edges: .top)
    }
    
    @StateObject var viewModel: GraphViewModel
}

// MARK: - ActivityView_Previews

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(viewModel: DependencyContainer.previewGraphScene)
    }
}
