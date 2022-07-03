//
//  MapPresenter.swift
//  Viajero
//
//  Created by Mikel Lopez Salazar on 3/7/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol MapPresenterProtocol {
    func firstLocation(location: CLLocation)
}

class MapPresenter {
    
    var delegate: MapPresenterProtocol?
    
    var actualLocation: CLLocation?
    
    func initLocationUpdates() {
        LocationManager.sharedInstance().startTrackingLocation(delegado: self)
    }
    
}

// MARK: LOCATION MANAGER
extension MapPresenter: LocationManagerProtocol {
    func locatedInLugar(lugar: Lugar) {
        print("Located in lugar")
    }
    
    func noLocatedInLugar(location: CLLocation?) {
        print("No located in Lugar")
    }
    
    func locationUpdated(location: CLLocation?) {
        print("LOCATION UPDATED")
        if let location = location {
            if actualLocation == nil {
                delegate?.firstLocation(location: location)
            }
            self.actualLocation = location
        }
    }
}
