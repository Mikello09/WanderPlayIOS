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
    func showLogros(logros: [Logro], lugarID: String)
}

class MapPresenter {
    
    var delegate: MapPresenterProtocol?
    var interactor: LugaresInteractor?
    
    var actualLocation: CLLocation?
    
    func initLocationUpdates() {
        LocationManager.sharedInstance().startTrackingLocation(delegado: self)
    }
    
    func checkForFirstTime() {
        if UserDefaults.standard.bool(forKey: "firstTime") {
            UserDefaults.standard.set(false, forKey: "firstTime")
            LogroWorker().askForLogros(lugar: "-1", delegate: self)
        }
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
        if let lugarID = lugar._id {
            LogroWorker().askForLogros(lugar: lugarID, delegate: self)
        }
    }
    
    func noLocatedInLugar(location: CLLocation?) {
        print("No located in Lugar")
    }
    
    func locationUpdated(location: CLLocation?) {
        print("LOCATION UPDATED")
        if let location = location {
            if actualLocation == nil {
                delegate?.firstLocation(location: location)
            } else {
                LocationManager.sharedInstance().isLocatedInLugar(location: location, delegate: self)
            }
            self.actualLocation = location
        }
    }
}

// MARK: LOGROS
extension MapPresenter: LogroWorkerProtocol {
    func logroSuccess(logros: [Logro], lugar: String) {
        delegate?.showLogros(logros: logros, lugarID: lugar)
    }
    
    func logroFail() {
        return
    }
}

// MARK: LUGARES INTERACTOR
extension MapPresenter: LugaresInteractorProtocol {
    
    func lugaresReceived(lugares: [Lugar]) {
        delegate?.showLugares(lugares: lugares)
    }
    func failGettingLugares() {
        
    }
}
