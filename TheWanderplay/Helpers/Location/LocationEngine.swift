//
//  LocationEngine.swift
//  Viajero
//
//  Created by Mikel Lopez on 26/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationEngineProtocol: class{
    func getGeolocation(location: CLLocation?)
}

protocol LocationEnginePermission{
    func notDetermined()
    func accepted()
    func denied()
}


class LocationEngine: NSObject, CLLocationManagerDelegate{
    
    var locationManager: CLLocationManager
    static var instance: LocationEngine!
    var delegate: LocationEngineProtocol!
    var changeDelegate: LocationEnginePermission?
    
    // Singleton
    class func sharedInstance() -> LocationEngine {
        self.instance = (self.instance ?? LocationEngine())
        return self.instance
    }
    
    override init(){
        locationManager = CLLocationManager()
    }

    func removeInstance(){
        LocationEngine.instance = nil
    }
    
    func startEngineForPermission(delegate: LocationEnginePermission){
        self.locationManager.delegate = self
        self.changeDelegate = delegate
        self.isLocationServicesEnabledAndAuthorized()
    }
    
    func startEngine(){
        checkPermissions()
        startUpatingUserLocation()
    }
    
    func checkPermissions(){
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpatingUserLocation(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingUserLocation(){
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locationManager.stopUpdatingLocation()
        delegate.getGeolocation(location: receiveLocationAndManage(locations: locations))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // We can catch this error with the future error handler
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
            case .notDetermined:
                print("do nothing")
            case .restricted, .denied:
                changeDelegate?.denied()
            case .authorizedAlways, .authorizedWhenInUse:
                changeDelegate?.accepted()
            default:
                changeDelegate?.denied()
        }
    }
    func receiveLocationAndManage(locations: [CLLocation]) -> CLLocation?{
        return chooseNewstLocation(locations: locations)
    }
    
    func chooseNewstLocation(locations: [CLLocation]?) -> CLLocation?{
            
            if let userLocation = locations?[0] {
                return userLocation
            } else {
                let locationsSorted = locations?.sorted {($0.timestamp > $1.timestamp)}
                return locationsSorted?.first
            }
        }
    
    public func isLocationServicesEnabledAndAuthorized() {
        checkPermissions()
//        if CLLocationManager.locationServicesEnabled() {
//            checkPermissions()
//            switch(CLLocationManager.authorizationStatus()) {
//            case .restricted, .denied:
//                ()
//                //changeDelegate?.denied()
//            case .notDetermined:
//                ()
//                //changeDelegate?.notDetermined()
//            case .authorizedAlways, .authorizedWhenInUse:
//                ()
//                //changeDelegate?.accepted()
//            default:
//                ()
//                //changeDelegate?.denied()
//            }
//        } else {
//            changeDelegate?.denied()
//        }
    }
    
    public func askPermision(){
        checkPermissions()
    }
    
    
    
    
}
