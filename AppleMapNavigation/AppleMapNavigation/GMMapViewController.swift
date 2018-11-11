//
//  GMMapViewController.swift
//  AppleMapNavigation
//
//  Created by Abhishek on 01/08/18.
//  Copyright © 2018 AbhishekShukla. All rights reserved.
//

import UIKit
import GoogleMaps

class GMMapViewController: UIViewController {

    let apiKey = "AIzaSyBzu64XvHEa6YobAWWEM-0vOhiLIjFkaDs"
    let pageTitle = "Google Maps"
    let lat = 28.591502
    let lng = 77.319041
    var camera: GMSCameraPosition?
    var mapView: GMSMapView?
    
    var currentPossitionButton: UIButton {
        let buttonRect =  CGRect(x: UIScreen.main.bounds.width-70, y: UIScreen.main.bounds.height-100, width: 45, height: 45)
        let button = UIButton(frame: buttonRect)
        button.setImage(#imageLiteral(resourceName: "current_location"), for: .normal)
        button.addTarget(self, action: #selector(handleCurrentPossition), for: .touchUpInside)
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerGoogleServices()
        prepareNavigationBar()
    }
    
    func prepareNavigationBar() {
        self.title = pageTitle
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleNextBarButton))
    }
    
    @objc func handleNextBarButton() {
        
    }
    
    func registerGoogleServices() {
        GMSServices.provideAPIKey(apiKey)
        camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 16)
        let rect = view.bounds
        mapView = GMSMapView.map(withFrame: rect, camera: camera!)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let marker = GMSMarker(position: currentLocation)
        marker.map = mapView

        mapView?.addSubview(currentPossitionButton)
    }
    
    @objc func handleCurrentPossition() {
        guard let camera = camera else { return }
        mapView?.animate(to: camera)
    }
}

