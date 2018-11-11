//
//  MKMapViewController.swift
//  AppleMapNavigation
//
//  Created by Abhishek on 01/08/18.
//  Copyright © 2018 AbhishekShukla. All rights reserved.
//

import UIKit
import Contacts
import MapKit

final class CurrentLocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    var region: MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}

class MKMapViewController: UIViewController {
    
    @IBOutlet weak var mkMapView: MKMapView!
    
    let pageTitle = "Apple Maps"
    let lat = 28.591502
    let lng = 77.319041
    
    var currentPossitionButton: UIButton {
        let buttonRect =  CGRect(x: UIScreen.main.bounds.width-70, y: UIScreen.main.bounds.height-100, width: 45, height: 45)
        let button = UIButton(frame: buttonRect)
        button.setImage(#imageLiteral(resourceName: "current_location"), for: .normal)
        button.addTarget(self, action: #selector(handleCurrentPossition), for: .touchUpInside)
        return button
    }
    
    @objc func handleCurrentPossition() {
        mkMapView.setRegion(mkMapView.region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationView()
        registerServices()
    }
    
    func prepareNavigationView() {
        self.title = pageTitle
    }
    
    func registerServices() {
//        mkMapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//
//        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
//        let currentLocationAnnotation = CurrentLocationAnnotation(coordinate: coordinate, title: "PaytmMall", subtitle: "F1, Sector 6, Noida")
//        mkMapView.addAnnotation(currentLocationAnnotation)
        
//        let camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: 1, pitch: 1, heading: 0)
//        mkMapView.setCamera(camera, animated: true)
        

//        mkMapView.setRegion(currentLocationAnnotation.region, animated: true)
//
//        mkMapView.addSubview(currentPossitionButton)
        
        let sourceCoordinate = CLLocationCoordinate2D(latitude: 39.173209, longitude: -94.593933)
        let destinationCoordinate = CLLocationCoordinate2D(latitude: 38.643172, longitude: -90.177429)
        let sourcePin = CurrentLocationAnnotation(coordinate: sourceCoordinate, title: "Connaught Place", subtitle: "Connaught Place")
        let destinationPin = CurrentLocationAnnotation(coordinate: destinationCoordinate, title: "Railway Station", subtitle: "allaha")
        mkMapView.addAnnotation(sourcePin)
        mkMapView.addAnnotation(destinationPin)
        prepareRoute()
        mkMapView.delegate = self
    }
    
    func prepareRoute() {
        
        let sourceCoordinate = CLLocationCoordinate2D(latitude: 39.173209, longitude: -94.593933)
        let destinationCoordinate = CLLocationCoordinate2D(latitude: 38.643172, longitude: -90.177429)
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinate)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let mapDirection = MKDirections(request: directionRequest)
        mapDirection.calculate { (response, error) in
            guard let directionResponse = response else {
                if let error = error {
                    print("Dirction Calculate ERROR: \(error.localizedDescription)")
                }
                return
            }
            
            let route = directionResponse.routes[0]
            self.mkMapView.add(route.polyline, level: .aboveRoads)
            
            let mapRect = route.polyline.boundingMapRect
            self.mkMapView.setRegion(MKCoordinateRegionForMapRect(mapRect), animated: true)
        }
    }
}

extension MKMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        renderer.lineWidth = 3.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let currentLocationAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView else { return nil }
        
        currentLocationAnnotationView.animatesWhenAdded = true
        currentLocationAnnotationView.titleVisibility = .adaptive
        currentLocationAnnotationView.subtitleVisibility = .adaptive
        
        return currentLocationAnnotationView
    }
}
