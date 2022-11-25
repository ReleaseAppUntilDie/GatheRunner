//
//  RunningRouteView.swift
//  GatheRunner
//
//  Created by hanJaeseung on 2022/11/13.
//

import SwiftUI
import MapKit

struct RunningRouteView: View {
    @ObservedObject var viewModel: RunningRouteViewModel

    var body: some View {
        MapWithPolyline(region: $viewModel.region, lineCoordinates: $viewModel.coordinates)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal, 30)
    }
}

//struct ResultMap_Previews: PreviewProvider {
//    static var previews: some View {
//        RunningRouteView(manager: LocationManager())
//    }
//}
