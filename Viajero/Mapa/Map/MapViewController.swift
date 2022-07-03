//
//  MapViewController.swift
//  Viajero
//
//  Created by Mikel Lopez Salazar on 24/6/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import MapboxMaps
import CoreLocation

class MapViewController: BaseViewController {
    
    var presenter: MapPresenter?
    
    var mapView: MapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.initLocationUpdates()
    }
    
    func loadMap(location: CLLocation) {
        let mapResourcesOptions = ResourceOptions(accessToken: "pk.eyJ1IjoibWlrZWxsbzA5IiwiYSI6ImNrNmkyd24wbzAyazgzZm16em9icmc3bzQifQ.fl7l_lXwzvY2DtAmLBuznQ")
        let mapInitOptions = MapInitOptions(
            resourceOptions: mapResourcesOptions,
            cameraOptions: nil,
            styleURI: StyleURI(url: URL(string: "mapbox://styles/mikello09/ck6i2yv8a00b91ip4ly880xcq")!))
        
        mapView = MapView(frame: self.view.bounds, mapInitOptions: mapInitOptions)
        mapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mapView?.mapboxMap.setCamera(to: CameraOptions(
            center: CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude),
            zoom: 9.0))
        
        self.view.addSubview(mapView ?? UIView())
    }
    
}

// MARK: PRESENTER
extension MapViewController: MapPresenterProtocol {
    func firstLocation(location: CLLocation) {
        loadMap(location: location)
    }
}
