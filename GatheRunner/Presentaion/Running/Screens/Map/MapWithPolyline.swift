//
//  MapWithPolyline.swift
//  GatheRunner
//
//  Created by hanjaeseung on 2022/11/19.
//

import SwiftUI
import MapKit

struct MapWithPolyline: UIViewRepresentable {
    
    @Binding var region: MKCoordinateRegion
    @Binding var lineCoordinates: [CLLocationCoordinate2D]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = region
        mapView.userTrackingMode = .follow
        let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
        mapView.addOverlay(polyline)
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        guard let startPosition = lineCoordinates.first , let endPosition = lineCoordinates.last else {
            return
        }
        
        let startCircle = MKCircle(center: startPosition, radius: 7)
        startCircle.circleType = .start
        view.addOverlay(startCircle)
        
        let endcircle = MKCircle(center: endPosition, radius: 7)
        endcircle.circleType = .end
        view.addOverlay(endcircle)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapWithPolyline
    
    init(_ parent: MapWithPolyline) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        zoomForAllOverlays(mapView: mapView)
        if let routePolyline = overlay as? MKPolyline {
            return drawPolyLine(polyLine: routePolyline)
        } else if overlay is MKCircle {
            return drawCircle(overlay: overlay)
        }
        return MKOverlayRenderer()
    }
    
    func drawCircle(overlay: MKOverlay) -> MKCircleRenderer{
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        let strokColor: UIColor = .white
        let color: UIColor = (circleRenderer.circle.circleType == .start) ? .green : .red
        circleRenderer.strokeColor = strokColor
        circleRenderer.fillColor = color
        circleRenderer.lineWidth = 2.0
        return circleRenderer
    }
    
    func drawPolyLine(polyLine: MKPolyline) -> MKPolylineRenderer {
        let renderer = MKPolylineRenderer(polyline: polyLine)
        renderer.strokeColor = UIColor.systemBlue
        renderer.lineWidth = 5
        return renderer
    }
    
    func zoomForAllOverlays(mapView: MKMapView) {
        let insets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        guard let initial = mapView.overlays.first?.boundingMapRect else { return }

        let mapRect = mapView.overlays
            .dropFirst()
            .reduce(initial) { $0.union($1.boundingMapRect) }

        mapView.setVisibleMapRect(mapRect, edgePadding: insets, animated: true)
    }
}

extension MKCircle {
    
    enum type {
        case start
        case end
    }
    
    private static var savedCircleType: type = .start
    
    var circleType: type {
        get{
            return MKCircle.savedCircleType
        }
        set(newValue) {
            MKCircle.savedCircleType = newValue
        }
    }
    
}
