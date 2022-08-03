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
    func showLugares(lugares: [Lugar])
    func showFirstTimeLogro()
}

class MapPresenter {
    
    var delegate: MapPresenterProtocol?
    var interactor: LugaresInteractor?
    
    var actualLocation: CLLocation?
    
    func initLocationUpdates() {
        LocationManager.sharedInstance().startTrackingLocation(delegado: self)
    }
    
    func checkForFirstTime() {
//        if UserDefaults.standard.bool(forKey: "firstTime") {
//            UserDefaults.standard.set(false, forKey: "firstTime")
//            delegate?.showFirstTimeLogro()
//        }
        delegate?.showFirstTimeLogro()
    }
    
    func getLugares() {
        delegate?.showLugares(lugares: Lugares.shared.getLugares())
    }
    
    func updateLugares() {
        interactor?.getLugares()
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

// MARK: INTERACTOR
extension MapPresenter: LugaresInteractorProtocol {
    
    func lugaresReceived(lugares: [Lugar]) {
        delegate?.showLugares(lugares: lugares)
    }
    func failGettingLugares() {
        
    }
}
