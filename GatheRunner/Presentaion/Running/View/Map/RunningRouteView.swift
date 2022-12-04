//
//  RunningRouteView.swift
//  GatheRunner
//
//  Created by hanJaeseung on 2022/11/13.
//

import SwiftUI
import MapKit

struct RunningRouteView: UIViewRepresentable {
    var routeVm: RunningRouteViewModel
    
    @State private var hasSetRegion = false
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        var drawItems = [MKOverlay]()
        let lineCoordinates = routeVm.coordinates
        
        setRegionOnce(view)

        addPolyline(&drawItems, with: lineCoordinates)
        addCircle(&drawItems, with: lineCoordinates)
        view.addOverlays(drawItems)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: NameSpace

extension RunningRouteView {
    fileprivate enum Size {
        static let circleRadius: CGFloat = 7
        static let circleLineWidth: CGFloat = 2
        static let polyLineLineWidth: CGFloat = 5
        static let zoomInset: CGFloat = 30
    }
}

// MARK: Private

extension RunningRouteView {
    private func addPolyline(_ drawItems: inout [MKOverlay], with coordinates: [CLLocationCoordinate2D]) {
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        drawItems.append(polyline)
    }
    
    private func addCircle(_ drawItems: inout [MKOverlay], with coordinates: [CLLocationCoordinate2D]) {
        guard let startPosition = coordinates.first, let endPosition = coordinates.last else {
            return
        }
        
        // MARK: Temp - start는 한번만 추가하도록 변경 예정
        
        let startCircle = MKCircle(center: startPosition, radius: Size.circleRadius)
        let endCircle = MKCircle(center: endPosition, radius: Size.circleRadius)
        
        drawItems.append(startCircle)
        drawItems.append(endCircle)
    }
    
    private func setRegionOnce(_ view: MKMapView) {
        
        // MARK: Temp - Modifying state during view update, this will cause undefined behavior. fix 예정

        guard !hasSetRegion else { return }
        hasSetRegion = true
        view.setRegion(routeVm.region, animated: false)
    }
}

// MARK: Coordinator

extension RunningRouteView {
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: RunningRouteView
        
        init(_ parent: RunningRouteView) {
            self.parent = parent
        }
                
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            zoomForAllOverlays(mapView: mapView)
            
            return drawMap(with: overlay)
        }
        
        func drawMap(with overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                return drawPolyLine(with: polyline)
            } else if let circle = overlay as? MKCircle {
                return drawCircle(with: circle)
            }
            return MKOverlayRenderer()
        }
        
        func drawCircle(with circle: MKCircle) -> MKCircleRenderer {
            
            // MARK: Temp - start,end에 따른 색상변경 추가 예정
            
            let renderer = MKCircleRenderer(circle: circle)
            renderer.strokeColor = UIColor.white
            renderer.fillColor = UIColor.red
            renderer.lineWidth = Size.circleLineWidth
            return renderer
        }
        
        func drawPolyLine(with polyLine: MKPolyline) -> MKPolylineRenderer {
            let renderer = MKPolylineRenderer(polyline: polyLine)
            renderer.strokeColor = UIColor.systemBlue
            renderer.lineWidth = Size.polyLineLineWidth
            return renderer
        }
        
        func zoomForAllOverlays(mapView: MKMapView) {
            let insets = UIEdgeInsets(top: Size.zoomInset, left: Size.zoomInset,
                                      bottom: Size.zoomInset, right: Size.zoomInset)
            guard let initial = mapView.overlays.first?.boundingMapRect else { return }
            
            let mapRect = mapView.overlays
                .dropFirst()
                .reduce(initial) { $0.union($1.boundingMapRect) }
            mapView.setVisibleMapRect(mapRect, edgePadding: insets, animated: true)
        }
    }
}

// MARK: - RunningRouteView_Previews

struct RunningRouteView_Previews: PreviewProvider {
    static var previews: some View {
        RunningRouteView(routeVm: DependencyContainer.previewRouteScene)
    }
}
