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
        self.mapAvatarView.configure(delegate: self)
        rightBarMenu.configure(delegate: self, from: self)
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
        mapView?.location.options.puckType = .puck2D(puck2DConfiguration)
        
        self.view.insertSubview(mapView ?? UIView(), at: 0)
    }
    
}

// MARK: PRESENTER
extension MapViewController: MapPresenterProtocol {
    func firstLocation(location: CLLocation) {
        loadMap(location: location)
        presenter?.getLugares()
    }
    
    func showLugares(lugares: [Lugar]) {
        
        mapView?.mapboxMap.onNext(.mapLoaded, handler: { loaded in
            //CREAR NUEVO ARCHIVO GEOJSON
            if Lugares.shared.existFileLugaresGJ(){
                Lugares.shared.removeGeoJSONFile()
            }
            Lugares.shared.createGeoJSONFile(lugares: lugares)
            
            
            let documentsURL = try! FileManager().url(for: .documentDirectory,
                                                      in: .userDomainMask,
                                                      appropriateFor: nil,
                                                      create: true)

            let privateDoc = documentsURL.appendingPathComponent("PrivateDocuments")
            let fileData = privateDoc.appendingPathComponent("LugaresGJ" + ".geojson")
            
            var geoJSONSource = GeoJSONSource()
            geoJSONSource.data = .url(fileData)
            geoJSONSource.cluster = true
            
            
            let expSum = Exp(operator: .sum, arguments: [.expression(Exp(.accumulated)), .expression(Exp(.get) {"sum"})])
//            let expSum = Exp (operator: .sum, ) {
//                Exp(.accumulated)
//                Exp(.get) { "sum" }
//            }
            //geoJSONSource.clusterProperties = ["sum": expSum]
//            geoJSONSource.clusterProperties = ["sum": Exp(.accumulated)] //["sum": Exp(.sum)]//["sum": ["+", ["get", "scalerank"]]]
            
            try? self.mapView?.mapboxMap.style.addSource(geoJSONSource, id: "SOURCE_ID")
            self.mapView?.mapboxMap.onNext(.sourceDataLoaded, handler: { _ in
                // PIN BAJO
                let iconoPinBajo = UIImage(named: "pin_verde_image")
                try? self.mapView?.mapboxMap.style.addImage(iconoPinBajo!.withRenderingMode(.alwaysTemplate), id: "pin_bajo")
                // PIN MEDIO
                let iconoPinMedio = UIImage(named: "pin_azul_image")
                try? self.mapView?.mapboxMap.style.addImage(iconoPinMedio!.withRenderingMode(.alwaysTemplate), id: "pin_medio")
                // PIN ALTO
                let iconoPinAlto = UIImage(named: "pin_amarillo_image")
                try? self.mapView?.mapboxMap.style.addImage(iconoPinAlto!.withRenderingMode(.alwaysTemplate), id: "pin_alto")
                // PIN MUY ALTO
                let iconoPinMuyAlto = UIImage(named: "pin_naranja_image")
                try? self.mapView?.mapboxMap.style.addImage(iconoPinMuyAlto!.withRenderingMode(.alwaysTemplate), id: "pin_muy_alto")
                // PIN PATRIMONIO
                let iconoPatrimonio = UIImage(named: "pin_rojo_image")
                try? self.mapView?.mapboxMap.style.addImage(iconoPatrimonio!.withRenderingMode(.alwaysTemplate), id: "pin_patrimonio")
                
                var pinLayer = SymbolLayer(id: "SYMBOL_ID")
                pinLayer.source = "SOURCE_ID"
                pinLayer.iconAllowOverlap = .constant(false)
//                pinLayer.filter = Expression(.not) {
//                    Expression(.has) { "point_count" }
//                }
                let pinExpression = Exp(.switchCase) {
                    Exp(.eq) {
                        Exp(.get) { "tipoLugar" }
                        "BAJO"
                    }
                    "pin_bajo"
                    Exp(.eq) {
                        Exp(.get) { "tipoLugar" }
                        "MEDIO"
                    }
                    "pin_medio"
                    Exp(.eq) {
                        Exp(.get) { "tipoLugar" }
                        "ALTO"
                    }
                    "pin_alto"
                    Exp(.eq) {
                        Exp(.get) { "tipoLugar" }
                        "MUYALTO"
                    }
                    "pin_muy_alto"
                    Exp(.eq) {
                        Exp(.get) { "tipoLugar" }
                        "PATRIMONIO"
                    }
                    "pin_patrimonio"
                    ""
                }
//                Expression(.has) { "point_count" }
//                "pin_cluster"
                let clusterExpression = Exp(.get) { "point_count" }
                
                pinLayer.iconImage = .expression(pinExpression)
                pinLayer.iconSize = .constant(0.5)
                
                pinLayer.textField = .expression(clusterExpression)
                
                do {
                    try self.mapView?.mapboxMap.style.addLayer(pinLayer)
                
                    let tap = UITapGestureRecognizer(target: self, action: #selector(self.mapTap(sender:)))
                    self.mapView?.addGestureRecognizer(tap)
                    
                } catch {
                    print(error)
                }
            })
        })
    }
    
   @objc
    func mapTap(sender: UITapGestureRecognizer) {
        print("tap")
        
        if self.view.subviews.filter({ $0.accessibilityIdentifier == "lugarInfoView" }).count > 0 {
            self.lugarInfoView?.removeFromSuperview()
        } else {
            let point = sender.location(in: sender.view)
            let width: CGFloat = (6 * 4)// iconoPin!.size.width
            let rect = CGRect(x: point.x - width / 2, y: point.y - width / 2, width: width, height: width)
            
            mapView?.mapboxMap.queryRenderedFeatures(in: rect, completion: { result in
                if let features = try? result.get() {
                    
                    let wanderplayFeature = features.filter({$0.feature.properties?["visitado"] != nil})
                    
                    switch wanderplayFeature.count {
                    case 0: print("No feature")
                    case 1:
                        if let feature = features.first?.feature {
                            if let nombre = (feature.properties?["nombre"] as? JSONValue)?.rawValue as? String,
                               let puntos = (feature.properties?["puntos"] as? JSONValue)?.rawValue as? String,
                               let foto = (feature.properties?["foto"] as? JSONValue)?.rawValue as? String,
                               let id = (feature.properties?["id"] as? JSONValue)?.rawValue as? String,
                               let tipoLugar = (feature.properties?["tipoLugar"] as? JSONValue)?.rawValue as? String,
                               let visitado = (feature.properties?["visitado"] as? JSONValue)?.rawValue as? String {
                                
                                let popup = UIView(frame: CGRect(x: 0, y: 0, width: 274, height: 300))
                                popup.backgroundColor = UIColor.white
                                popup.addShadowInContainerView()
                                
                                self.lugarInfoView = LugarInfoView(frame: CGRect(x: self.mapView!.bounds.width/2 - (274/2),
                                                                                 y: self.mapView!.bounds.height/2 - (300/2),
                                                                            width: 274,
                                                                            height: 300))
                                self.lugarInfoView?.accessibilityIdentifier = "lugarInfoView"
                                self.lugarInfoView?.configure(nombre: nombre,
                                                         puntos: puntos,
                                                         foto: foto,
                                                         id: id,
                                                         tipoLugar: tipoLugar,
                                                         visitado: visitado,
                                                         delegate: self)
                                self.view.addSubview(self.lugarInfoView ?? UIView())
                            }
                        }
                    default: print("many features")
                    }
                } else {
                    print("error")
                }
            })
        }
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
        //self.interactor?.getLugares()
    }
    
    func filterClicked() {
        
    }
}
        
        
        
    

