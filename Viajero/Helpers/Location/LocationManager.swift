//
//  LocationManager.swift
//  Viajero
//
//  Created by Mikel Lopez on 26/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationManagerProtocol {
    func locatedInLugar(lugar: Lugar)
    func noLocatedInLugar(location: CLLocation?)
    func locationUpdated(location: CLLocation?)
}

class LocationManager{
    
    static var instance: LocationManager!
    let locationEngine: LocationEngine!
    var delegate: LocationManagerProtocol?
    private var actualLocation: CLLocation?
    private var lastLocation: CLLocation?
    
    class func sharedInstance() -> LocationManager {
        self.instance = (self.instance ?? LocationManager())
        return self.instance
    }
    
    init(){
        locationEngine = LocationEngine.sharedInstance()
    }
    
    func hasUpdatedLocation(location: CLLocation?){
        self.actualLocation = location
        guard let _ = self.lastLocation else {//inicializar lastlocation
            self.lastLocation = self.actualLocation
            delegate?.locationUpdated(location: location)//la primera vez tiene que llamarse
            return
        }
        if actualLocation!.distance(from: lastLocation!) > 1 {//preguntar por lugar cuando te muevas 1 metros
            lastLocation = actualLocation//refrescar lastlocation
            delegate?.locationUpdated(location: location)
        }
    }
    
    func startTrackingLocation(delegado: LocationManagerProtocol) {
        self.delegate = delegado
        locationEngine.delegate = self
        locationEngine.startUpatingUserLocation()
    }
    
    func isLocatedInLugar(location: CLLocation?, delegate: LocationManagerProtocol){
        self.delegate = delegate
        if let location = location{
            self.actualLocation = location
            LugaresManager.shared.mustApplyFilters = false
            LugaresManager.shared.getLugares(delegate: self)
        }
    }
    
    func stopTrackingLocation() {
        self.delegate = nil
        locationEngine.stopUpdatingUserLocation()
    }
    
}

extension LocationManager: LocationEngineProtocol{
    func getGeolocation(location: CLLocation?) {
        self.hasUpdatedLocation(location: location)
    }
}

extension LocationManager: LugaresManagerProtocol{
    
    
    func lugaresUpdated(lugares: [Lugar]?) {
        if let location = self.actualLocation{
            if let lugares = lugares{
                for lugar in lugares{
                   let lugarCLLocation = CLLocation(latitude: Double(lugar.latitud ?? "0.0") ?? 0.0, longitude: Double(lugar.longitud ?? "0.0") ?? 0.0)
                    print("DISTANCIA:",lugarCLLocation.distance(from: location))
                    if lugarCLLocation.distance(from: location) < 50 {
                        delegate?.locatedInLugar(lugar: lugar)//el delegado es nulo
                        return
                   }
               }
            }
            delegate?.noLocatedInLugar(location: location)
        }
    }
    
    func failGettingLugares() {
        if let location = self.actualLocation{
            delegate?.noLocatedInLugar(location: location)
        }
    }
    
    
}
