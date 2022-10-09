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
    
    @IBOutlet weak var filtrosInteresView: FiltrosInteresView!
    @IBOutlet weak var activeFilterView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var filtrosCategoriaView: FiltrosCategoriaView!
    @IBOutlet weak var mapAvatarView: MapAvatarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.initLocationUpdates()
        mapAvatarView.configure(delegate: self)
        filtrosInteresView.configure(delegate: self)
        filtrosCategoriaView.configure(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapAvatarView.updateLevel()
    }
    
    func setupUI() {
        activeFilterView.layer.cornerRadius = 8
        helpView.layer.cornerRadius = 8
    }
    
    func loadMap(location: CLLocation) {
        let mapResourcesOptions = ResourceOptions(accessToken: "pk.eyJ1IjoibWlrZWxsbzA5IiwiYSI6ImNrNmkyd24wbzAyazgzZm16em9icmc3bzQifQ.fl7l_lXwzvY2DtAmLBuznQ")
        let mapInitOptions = MapInitOptions(
            resourceOptions: mapResourcesOptions,
            cameraOptions: nil,
            styleURI: StyleURI(url: URL(string: "mapbox://styles/mikello09/ck6i2yv8a00b91ip4ly880xcq")!))
        
        mapView = MapView(frame: self.view.bounds, mapInitOptions: mapInitOptions)
        mapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // CAMERA
        mapView?.mapboxMap.setCamera(to: CameraOptions(
            center: CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude),
            zoom: UserSettings.getZoomLevel(),
            pitch: 60))
        
        // ATTRIBUTION
        mapView?.ornaments.attributionButton.isHidden = true
        mapView?.ornaments.logoView.isHidden = true
        mapView?.ornaments.compassView.isHidden = true
        mapView?.ornaments.scaleBarView.isHidden = true
        
        // PUCK CONFIGURATION
//        var puck2DConfiguration = Puck2DConfiguration()
//        puck2DConfiguration.topImage = UIImage(named: "Mikel")
//        puck2DConfiguration.scale = .constant(0.05)
//        mapView?.location.options.puckType = .puck2D(puck2DConfiguration)
        
        if let modelURL = Bundle.main.url(forResource: "Mikel",
                                          withExtension: "glb") {
            let userModel = Model(uri: modelURL, orientation: [0, 0, 180])
            let puck3Configuration = Puck3DConfiguration(model: userModel, modelScale: .constant([0.8, 0.8, 0.8]))
            mapView?.location.options.puckType = .puck3D(puck3Configuration)
        }
        
        self.view.insertSubview(mapView ?? UIView(), at: 0)
    }
    
    @IBAction func onHelp(_ sender: Any) {
        FiltrosTutorialRouter().goToFiltrosTutorial(navigationController: self.navigationController)
    }
    
    @IBAction func onActiveFilter(_ sender: Any) {
        if filtrosInteresView.isHidden {
            filtrosInteresView.isHidden = false
            filtrosCategoriaView.isHidden = false
        } else {
            filtrosInteresView.isHidden = true
            filtrosCategoriaView.isHidden = true
        }
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
        
        mapView?.mapboxMap.onEvery(.cameraChanged, handler: { _ in
            let zoomLevel = self.mapView?.cameraState.zoom ?? 18
            UserSettings.setZoomLevel(zoomLevel: zoomLevel)
        })
        
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

// MARK: FILTROS
extension MapViewController: FiltrosInteresViewProtocol, FiltrosCategoriaViewProtocol {
    func updateInteresLugares(interesFiltros: [Interes]) {
        FiltrosManager.shared.setInteresFiltros(interesFiltros: interesFiltros)
        presenter?.updateLugares()
    }
    
    func categoriaSelected(categorias: [Categoria]) {
        FiltrosManager.shared.setCategoriaFiltros(categoriaFiltros: categorias)
        presenter?.updateLugares()
    }
}
