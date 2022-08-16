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
import SwiftUI

class MapViewController: BaseViewController {
    
    var presenter: MapPresenter?
    
    var mapView: MapView?
    var lugarInfoView: LugarInfoView?
    @IBOutlet weak var rightBarMenu: RightBarMenu!
    @IBOutlet weak var mapAvatarView: MapAvatarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.initLocationUpdates()
        mapAvatarView.configure(delegate: self)
        rightBarMenu.configure(delegate: self, from: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapAvatarView.updateLevel()
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
        
        // PUCK CONFIGURATION
        var puck2DConfiguration = Puck2DConfiguration()
        puck2DConfiguration.topImage = UIImage(named: "Inspector")
        puck2DConfiguration.scale = .constant(0.05)
        //mapView?.location.options.puckType = .puck2D(puck2DConfiguration)
        
        if let modelURL = Bundle.main.url(forResource: "sportcar",
                                          withExtension: "glb") {
            let userModel = Model(uri: modelURL, orientation: [0, 0, 180])
            let puck3Configuration = Puck3DConfiguration(model: userModel, modelScale: .constant([0.2, 0.2, 0.2]))
            mapView?.location.options.puckType = .puck3D(puck3Configuration)
        }
        
        self.view.insertSubview(mapView ?? UIView(), at: 0)
    }
    
}

// MARK: PRESENTER
extension MapViewController: MapPresenterProtocol {
    func firstLocation(location: CLLocation) {
        loadMap(location: location)
        mapView?.mapboxMap.onNext(.mapLoaded, handler: { loaded in
            self.presenter?.getLugares()
        })
        presenter?.checkForFirstTime()
    }
    
    func showLogros(logros: [Logro], lugarID: String) {
        DispatchQueue.main.async {
            LogrosRouter().goToLogros(navigationController: self.navigationController, logros: logros, lugar: lugarID)
        }
    }
    
    func showLugares(lugares: [Lugar]) {
        loadMapboxLayer(lugares: lugares)
    }
}

// MARK: LUGAR INFO VIEW
extension MapViewController: LugarInfoViewProtocol {
    func onGoToDetalles(idLugar: String) {
        LugarDetailRouter().goToLugarDetail(navigationController: self.navigationController, idLugar: idLugar)
    }
}

// MARK: MAP AVATAR VIEW
extension MapViewController: MapAvatarViewProtocol {
    func onMapAvatarViewSelected() {
        PersonalDataRouter().goToPersonalData(navigationController: self.navigationController)
    }
}

// MARK: RIGHT BAR MENU
extension MapViewController: RightBarMenuProtocol {
    func updateTipoLugares(tipoFiltros: [TipoLugar]) {
        FiltrosManager.shared.setFiltros(categoriaFiltros: FiltrosManager.shared.categoriaFiltros, tipoLugaresFiltros: tipoFiltros)
        presenter?.updateLugares()
    }
    
    func filterClicked() {
        
    }
}
