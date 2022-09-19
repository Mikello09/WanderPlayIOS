//
//  MapBoxHelper.swift
//  Viajero
//
//  Created by Mikel Lopez Salazar on 27/7/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import MapboxMaps

extension MapViewController {
    
    func loadMapboxLayer(lugares: [Lugar]) {
        try? self.mapView?.mapboxMap.style.removeLayer(withId: "SYMBOL_ID")
        try? self.mapView?.mapboxMap.style.removeSource(withId: "SOURCE_ID")
        
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
        
        try? self.mapView?.mapboxMap.style.addSource(geoJSONSource, id: "SOURCE_ID")
        self.mapView?.mapboxMap.onNext(.sourceDataLoaded, handler: { _ in
            // VISITADO
            let iconoVisitado = UIImage(named: "earth_icono")
            try? self.mapView?.mapboxMap.style.addImage(iconoVisitado!.withRenderingMode(.alwaysTemplate), id: "pin_visitado")
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
            // CLUSTER ICON
            let clustericon = UIImage(named: "cluster_icon")
            try? self.mapView?.mapboxMap.style.addImage(clustericon!.withRenderingMode(.alwaysTemplate), id: "cluster_icon")
            
            var pinLayer = SymbolLayer(id: "SYMBOL_ID")
            pinLayer.source = "SOURCE_ID"
            pinLayer.iconAllowOverlap = .constant(false)
            
            let pinExpression = Exp(.switchCase) {
                Exp(.has) { "point_count" }
                "cluster_icon"
                Exp(.eq) {
                    Exp(.get) { "visitado" }
                    "si"
                }
                "pin_visitado"
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
            
            let clusterExpression = Exp(.get) { "point_count" }
            
            pinLayer.iconImage = .expression(pinExpression)
            pinLayer.iconSize = .constant(0.5)
            
            pinLayer.textField = .expression(clusterExpression)
            pinLayer.textColor = .constant(StyleColor(UIColor.principal))
            pinLayer.textFont = .constant([])
            
            do {
                try self.mapView?.mapboxMap.style.addLayer(pinLayer)
            
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.mapTap(sender:)))
                self.mapView?.addGestureRecognizer(tap)
                
            } catch {
                print(error)
            }
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
