//
//  MapaDelegates.swift
//  Viajero
//
//  Created by Mikel Lopez on 20/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import Lottie
import MapboxMaps
import Kingfisher
import SceneKit

private let kLugarAnnotationPatrimonio = "kLugarAnnotationPatrimonio"
private let kLugarAnnotationMuyAlto = "kLugarAnnotationMuyAlto"
private let kLugarAnnotationAlto = "kLugarAnnotationAlto"
private let kLugarAnnotationMedio = "kLugarAnnotationMedio"
private let kLugarAnnotationBajo = "kLugarAnnotationBajo"
private let kLugarAnnotationVisitado = "kLugarAnnotationVisitado"
private let regionZoom = 0.3

class MasInfoButton: UIButton{
    var id: String = ""
}

//extension MapaViewController{
//
//    func mapView(_ mapView: MapView, didFinishLoading style: Style) {
//        addPinLayer()
//
////        let icon = UIImage(named: "pin_azul_image")!
////
////        // Retrieve data and set as source. This associates the data with the map, but style layers are still required to make data visible.
////        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "ports", ofType: "geojson")!)
////        let source = MGLShapeSource(identifier: "clusteredPorts",
////        url: url,
////        options: [.clustered: true, .clusterRadius: icon.size.width])
////        style.addSource(source)
////
////        // Show unclustered features as icons. The `cluster` attribute is built into clustering-enabled source features.
////        // This example requires two style layers to work properly: one for clustered points and one for unclustered points
////        let markerLayer = MGLSymbolStyleLayer(identifier: "ports", source: source)
////        markerLayer.iconImageName = NSExpression(forConstantValue: "marker")
////        markerLayer.predicate = NSPredicate(format: "cluster != YES")
////        style.addLayer(markerLayer)
////        style.setImage(UIImage(named: "pin_azul_image")!, forName: "marker")
////
////        // Create style layer to cluster features as images with labels
////        let clusterLayer = MGLSymbolStyleLayer(identifier: "clusteredPortsNumbers", source: source)
////        clusterLayer.textColor = NSExpression(forConstantValue: UIColor.white)
////        clusterLayer.textFontSize = NSExpression(forConstantValue: NSNumber(value: Double(icon.size.width) / 2))
////        clusterLayer.iconAllowsOverlap = NSExpression(forConstantValue: true)
////
////        // Style image clusters
////        style.setImage(UIImage(named: "pin_azul_image")!, forName: "squircle")
////        style.setImage(UIImage(named: "pin_azul_image")!, forName: "circle")
////        style.setImage(UIImage(named: "pin_azul_image")!, forName: "rectangle")
////        style.setImage(UIImage(named: "pin_azul_image")!, forName: "star")
////        style.setImage(UIImage(named: "pin_azul_image")!, forName: "oval")
////
////        let stops = [
////        10: NSExpression(forConstantValue: "circle"),
////        25: NSExpression(forConstantValue: "rectangle"),
////        75: NSExpression(forConstantValue: "star"),
////        150: NSExpression(forConstantValue: "oval")
////        ]
////
////        // Use expressions to set each cluster's image based on defined stops and display the point count over the corresponding image
////        let defaultShape = NSExpression(forConstantValue: "squircle")
////        clusterLayer.iconImageName = NSExpression(format: "mgl_step:from:stops:(point_count, %@, %@)", defaultShape, stops)
////        clusterLayer.text = NSExpression(format: "CAST(point_count, 'NSString')")
////
////        style.addLayer(clusterLayer)
//
//    }
//
//    public func addPinLayer(){
//
//
//
//
//        let documentsURL = try! FileManager().url(for: .documentDirectory,
//                                                      in: .userDomainMask,
//                                                      appropriateFor: nil,
//                                                      create: true)
//
//        let privateDoc = documentsURL.appendingPathComponent("PrivateDocuments")
//        let fileData = privateDoc.appendingPathComponent("LugaresGJ" + ".geojson")
//
//        let source = MGLShapeSource(identifier: "lugaresPins",
//                                    url: fileData,
//                                    options: [.clustered: true, .clusterRadius: iconoPin!.size.width])
//        mapBox.style?.addSource(source)
//
//        mapBox.style?.setImage(iconoPin!.withRenderingMode(.alwaysTemplate), forName: "pin")
//        mapBox.style?.setImage(visitadoPin!.withRenderingMode(.alwaysTemplate), forName: "flag")
//
//        verde = MGLSymbolStyleLayer(identifier: "verde", source: source)
//        verde!.iconImageName = NSExpression(forConstantValue: "pin")
//        verde!.iconColor = NSExpression(forConstantValue: Colors.verde)
//        verde!.predicate = NSPredicate(format: "cluster != YES && %K == %@ && %K == %@","tipoLugar","BAJO", "visitado", "no")
//        verde!.iconAllowsOverlap = NSExpression(forConstantValue: true)
//        mapBox.style?.addLayer(verde!)
//
//
//
//        azul = MGLSymbolStyleLayer(identifier: "azul", source: source)
//        azul!.iconImageName = NSExpression(forConstantValue: "pin")
//        azul!.iconColor = NSExpression(forConstantValue: Colors.azul)
//        azul!.predicate = NSPredicate(format: "cluster != YES && %K == %@ && %K == %@","tipoLugar","MEDIO", "visitado", "no")
//        azul!.iconAllowsOverlap = NSExpression(forConstantValue: true)
//        mapBox.style?.addLayer(azul!)
//
//        amarillo = MGLSymbolStyleLayer(identifier: "amarillo", source: source)
//        amarillo!.iconImageName = NSExpression(forConstantValue: "pin")
//        amarillo!.iconColor = NSExpression(forConstantValue: Colors.amarillo)
//        amarillo!.predicate = NSPredicate(format: "cluster != YES && %K == %@ && %K == %@","tipoLugar","ALTO", "visitado", "no")
//        amarillo!.iconAllowsOverlap = NSExpression(forConstantValue: true)
//        mapBox.style?.addLayer(amarillo!)
//
//        naranja = MGLSymbolStyleLayer(identifier: "naranja", source: source)
//        naranja!.iconImageName = NSExpression(forConstantValue: "pin")
//        naranja!.iconColor = NSExpression(forConstantValue: Colors.naranja)
//        naranja!.predicate = NSPredicate(format: "cluster != YES && %K == %@ && %K == %@","tipoLugar","MUYALTO", "visitado", "no")
//        naranja!.iconAllowsOverlap = NSExpression(forConstantValue: true)
//        mapBox.style?.addLayer(naranja!)
//
//        rojo = MGLSymbolStyleLayer(identifier: "rojo", source: source)
//        rojo!.iconImageName = NSExpression(forConstantValue: "pin")
//        rojo!.iconColor = NSExpression(forConstantValue: Colors.rojo)
//        rojo!.predicate = NSPredicate(format: "cluster != YES && %K == %@ && %K == %@","tipoLugar","PATRIMONIO", "visitado", "no")
//        rojo!.iconAllowsOverlap = NSExpression(forConstantValue: true)
//        mapBox.style?.addLayer(rojo!)
//
//        visitado = MGLSymbolStyleLayer(identifier: "visitado", source: source)
//        visitado!.iconImageName = NSExpression(forConstantValue: "flag")
//        visitado!.iconColor = NSExpression(forConstantValue: Colors.amarillo)
//        visitado!.predicate = NSPredicate(format: "cluster != YES && %K == %@", "visitado", "si")
//        visitado!.iconAllowsOverlap = NSExpression(forConstantValue: true)
//        mapBox.style?.addLayer(visitado!)
//
//
//        // Color clustered features based on clustered point counts.
//        let stops = [
//            20: UIColor.lightGray,
//            50: UIColor.lightGray,
//            100: UIColor.lightGray,
//            200: UIColor.lightGray
//        ]
//
//        // Show clustered features as circles. The `point_count` attribute is built into
//        // clustering-enabled source features.
//        let circlesLayer = MGLCircleStyleLayer(identifier: "clusteredCircles", source: source)
//        circlesLayer.circleRadius = NSExpression(forConstantValue: NSNumber(value: Double(iconoPin!.size.width) / 2))
//        circlesLayer.circleOpacity = NSExpression(forConstantValue: 0.75)
//        circlesLayer.circleStrokeColor = NSExpression(forConstantValue: UIColor.white.withAlphaComponent(0.75))
//        circlesLayer.circleStrokeWidth = NSExpression(forConstantValue: 2)
//        circlesLayer.circleColor = NSExpression(format: "mgl_step:from:stops:(point_count, %@, %@)", UIColor.lightGray, stops)
//        circlesLayer.predicate = NSPredicate(format: "cluster == YES")
//        mapBox.style?.addLayer(circlesLayer)
//
//        // Label cluster circles with a layer of text indicating feature count. The value for
//        // `point_count` is an integer. In order to use that value for the
//        // `MGLSymbolStyleLayer.text` property, cast it as a string.
//        let numbersLayer = MGLSymbolStyleLayer(identifier: "clusteredCircleNumbers", source: source)
//        numbersLayer.textColor = NSExpression(forConstantValue: UIColor.white)
//        numbersLayer.textFontSize = NSExpression(forConstantValue: NSNumber(value: Double(iconoPin!.size.width) / 2))
//        numbersLayer.iconAllowsOverlap = NSExpression(forConstantValue: true)
//        numbersLayer.text = NSExpression(format: "CAST(point_count, 'NSString')")
//
//        numbersLayer.predicate = NSPredicate(format: "cluster == YES")
//        mapBox.style?.addLayer(numbersLayer)
//    }
//
//    private func firstCluster(with gestureRecognizer: UIGestureRecognizer) -> MGLPointFeatureCluster? {
//        let point = gestureRecognizer.location(in: gestureRecognizer.view)
//        let width = iconoPin!.size.width
//        let rect = CGRect(x: point.x - width / 2, y: point.y - width / 2, width: width, height: width)
//
//        // This example shows how to check if a feature is a cluster by
//        // checking for that the feature is a `MGLPointFeatureCluster`. Alternatively, you could
//        // also check for conformance with `MGLCluster` instead.
//        let features = mapBox.visibleFeatures(in: rect, styleLayerIdentifiers: ["clusteredPorts", "ports"])
//        let clusters = features.compactMap { $0 as? MGLPointFeatureCluster }
//
//        // Pick the first cluster, ideally selecting the one nearest nearest one to
//        // the touch point.
//        return clusters.first
//    }
//
//    @objc func handleDoubleTapCluster(sender: UITapGestureRecognizer) {
//
//        guard let source = mapBox.style?.source(withIdentifier: "lugaresPins") as? MGLShapeSource else {
//        return
//        }
//
//        guard sender.state == .ended else {
//        return
//        }
//
//        showPopup(false, animated: false)
//
//        guard let cluster = firstCluster(with: sender) else {
//        return
//        }
//
//        let zoom = source.zoomLevel(forExpanding: cluster)
//
//        if zoom > 0 {
//        mapBox.setCenter(cluster.coordinate, zoomLevel: zoom, animated: true)
//        }
//    }
//
//    @objc func handleMapTap(sender: UITapGestureRecognizer) {
//
//        guard let source = mapBox.style?.source(withIdentifier: "lugaresPins") as? MGLShapeSource else {
//        return
//        }
//
//        guard sender.state == .ended else {
//        return
//        }
//
//        showPopup(false, animated: false)
//
//        let point = sender.location(in: sender.view)
//        let width = (iconoPin!.size.width * 4)
//        let rect = CGRect(x: point.x - width / 2, y: point.y - width / 2, width: width, height: width)
//
//        let features = mapBox.visibleFeatures(in: rect, styleLayerIdentifiers: ["clusteredCircles", "verde", "azul", "amarillo", "naranja", "rojo", "visitado"])
//
//        // Pick the first feature (which may be a port or a cluster), ideally selecting
//        // the one nearest nearest one to the touch point.
//        guard let feature = features.first else {
//        return
//        }
//
//        if
//            let nombre = feature.attribute(forKey: "nombre") as? String,
//            let puntos = feature.attribute(forKey: "puntos") as? String,
//            let foto = feature.attribute(forKey: "foto") as? String,
//            let id = feature.attribute(forKey: "id") as? String,
//            let tipoLugar = feature.attribute(forKey: "tipoLugar") as? String,
//            let visitado = feature.attribute(forKey: "visitado") as? String{
//
//                popup = popup(at: feature.coordinate,
//                              nombre: nombre,
//                              puntos: puntos,
//                              foto: foto,
//                              id: id,
//                              tipoLugar: tipoLugar,
//                              visitado: visitado)
//                showPopup(true, animated: true)
//        }
//
//    }
//
//    private func popup(
//        at coordinate: CLLocationCoordinate2D,
//        nombre: String,
//        puntos: String,
//        foto: String,
//        id: String,
//        tipoLugar: String,
//        visitado: String) -> UIView {
//
//
//        let popup = UIView(frame: CGRect(x: 0, y: 0, width: 274, height: 300))
//        popup.backgroundColor = UIColor.white
//        popup.addShadowInContainerView()
//
//
//        let pinImage = UIImageView()
//        pinImage.translatesAutoresizingMaskIntoConstraints = false
//        switch tipoLugar {
//        case "BAJO":
//            pinImage.image = UIImage(named: "pin_verde_image")
//        case "MEDIO":
//            pinImage.image = UIImage(named: "pin_azul_image")
//        case "ALTO":
//            pinImage.image = UIImage(named: "pin_amarillo_image")
//        case "MUYALTO":
//            pinImage.image = UIImage(named: "pin_naranja_image")
//        case "PATRIMONIO":
//            pinImage.image = UIImage(named: "pin_rojo_image")
//        default:
//            print("")
//        }
//        popup.addSubview(pinImage)
//        pinImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        pinImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        pinImage.leadingAnchor.constraint(equalTo: popup.leadingAnchor, constant: 8).isActive = true
//        pinImage.topAnchor.constraint(equalTo: popup.topAnchor, constant: 8).isActive = true
//
//        let title = UILabel()
//        title.translatesAutoresizingMaskIntoConstraints = false
//        title.text = nombre
//        title.font = UIFont(name: "KohinoorBangla-Semibold", size: 18)
//        title.textColor = UIColor.black
//        title.textAlignment = .left
//        title.adjustsFontSizeToFitWidth = true
//        title.numberOfLines = 2
//        popup.addSubview(title)
//        title.centerYAnchor.constraint(equalTo: pinImage.centerYAnchor).isActive = true
//        title.leadingAnchor.constraint(equalTo: pinImage.trailingAnchor, constant: 3).isActive = true
//        title.trailingAnchor.constraint(equalTo: popup.trailingAnchor, constant: -12).isActive = true
//
//        let fotoView = UIImageView()
//        fotoView.translatesAutoresizingMaskIntoConstraints = false
//        fotoView.layer.masksToBounds = true
//        fotoView.layer.cornerRadius = 3
//        switch tipoLugar {
//            case "BAJO":
//                fotoView.layer.borderColor = Colors.verde.cgColor
//            case "MEDIO":
//                fotoView.layer.borderColor = Colors.azul.cgColor
//            case "ALTO":
//                fotoView.layer.borderColor = Colors.amarillo.cgColor
//            case "MUYALTO":
//                fotoView.layer.borderColor = Colors.naranja.cgColor
//            case "PATRIMONIO":
//                fotoView.layer.borderColor = Colors.rojo.cgColor
//            default:
//                fotoView.layer.borderColor = UIColor.black.cgColor
//        }
//        fotoView.layer.borderWidth = 2
//        if let url = URL(string: foto){
//            let resource = ImageResource(downloadURL: url)
//            if #available(iOS 13.0, *) {
//                fotoView.kf.setImage(with: resource, placeholder: UIImage.init(systemName: "photo"))
//                fotoView.tintColor = Colors.gris
//            }
//        }
//        popup.addSubview(fotoView)
//        fotoView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        fotoView.topAnchor.constraint(equalTo: pinImage.bottomAnchor, constant: 12).isActive = true
//        fotoView.leadingAnchor.constraint(equalTo: popup.leadingAnchor, constant: 12).isActive = true
//        fotoView.trailingAnchor.constraint(equalTo: popup.trailingAnchor, constant: -12).isActive = true
//
//        let puntosView = UIView()
//        puntosView.translatesAutoresizingMaskIntoConstraints = false
//        puntosView.layer.cornerRadius = 8
//        puntosView.layer.borderWidth = 2
//        puntosView.layer.borderColor = Colors.amarillo.cgColor
//        popup.addSubview(puntosView)
//        puntosView.topAnchor.constraint(equalTo: fotoView.bottomAnchor, constant: 18).isActive = true
//        puntosView.leadingAnchor.constraint(equalTo: popup.leadingAnchor, constant: 12).isActive = true
//        puntosView.widthAnchor.constraint(equalToConstant: popup.frame.width/2 - 24).isActive = true
//        puntosView.bottomAnchor.constraint(equalTo: popup.bottomAnchor, constant:  -18).isActive = true
//
//
//            let puntosImage = UIImageView()
//            puntosImage.translatesAutoresizingMaskIntoConstraints = false
//            puntosImage.image = visitado == "si" ? UIImage(named: "flag") : UIImage(named: "coins")
//            puntosImage.widthAnchor.constraint(equalToConstant: 32).isActive = true
//            puntosImage.heightAnchor.constraint(equalToConstant: 32).isActive = true
//            puntosView.addSubview(puntosImage)
//            puntosImage.leadingAnchor.constraint(equalTo: puntosView.leadingAnchor, constant: 8).isActive = true
//            puntosImage.centerYAnchor.constraint(equalTo: puntosView.centerYAnchor).isActive = true
//
//            let puntosLabel = UILabel()
//            puntosLabel.translatesAutoresizingMaskIntoConstraints = false
//            puntosLabel.textColor = Colors.gris
//            puntosLabel.font = UIFont(name: "KohinoorBangla-Semibold", size: 18)
//            puntosLabel.adjustsFontSizeToFitWidth = true
//            puntosLabel.text = visitado == "si" ? "Visitado" : "\(puntos)"
//            puntosLabel.textAlignment = .center
//            puntosView.addSubview(puntosLabel)
//            puntosLabel.trailingAnchor.constraint(equalTo: puntosView.trailingAnchor, constant: -8).isActive = true
//            puntosLabel.leadingAnchor.constraint(equalTo: puntosImage.trailingAnchor, constant: 3).isActive = true
//            puntosLabel.centerYAnchor.constraint(equalTo: puntosView.centerYAnchor).isActive = true
//
//
//
//
//        let masInfoView = MasInfoButton()
//        masInfoView.translatesAutoresizingMaskIntoConstraints = false
//        masInfoView.addShadowInContainerView(withRadius: 8)
//        masInfoView.backgroundColor = Colors.amarillo
//        masInfoView.id = id
//        masInfoView.addTarget(self, action: #selector(goToDetalle), for: .touchUpInside)
//        popup.addSubview(masInfoView)
//        masInfoView.topAnchor.constraint(equalTo: fotoView.bottomAnchor, constant: 18).isActive = true
//        masInfoView.bottomAnchor.constraint(equalTo: popup.bottomAnchor, constant: -18).isActive = true
//        masInfoView.trailingAnchor.constraint(equalTo: popup.trailingAnchor, constant: -12).isActive = true
//        masInfoView.widthAnchor.constraint(equalToConstant: popup.frame.width/2 - 24).isActive = true
//
//        let infoImage = UIImageView()
//        infoImage.translatesAutoresizingMaskIntoConstraints = false
//        if #available(iOS 13.0, *) {
//            infoImage.image = UIImage.init(systemName: "info.circle.fill")
//        }
//        infoImage.tintColor = UIColor.white
//        popup.addSubview(infoImage)
//        infoImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
//        infoImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        infoImage.leadingAnchor.constraint(equalTo: masInfoView.leadingAnchor, constant: 8).isActive = true
//        infoImage.centerYAnchor.constraint(equalTo: masInfoView.centerYAnchor).isActive = true
//
//        let infoLabel = UILabel()
//        infoLabel.translatesAutoresizingMaskIntoConstraints = false
//        infoLabel.adjustsFontSizeToFitWidth = true
//        infoLabel.text = "Más info"
//        infoLabel.textColor = UIColor.white
//        infoLabel.font = UIFont(name: "KohinoorBangla-Semibold", size: 18)
//        infoLabel.numberOfLines = 1
//        popup.addSubview(infoLabel)
//        infoLabel.leadingAnchor.constraint(equalTo: infoImage.trailingAnchor, constant: 8).isActive = true
//        infoLabel.trailingAnchor.constraint(equalTo: masInfoView.trailingAnchor, constant: -8).isActive = true
//        infoLabel.centerYAnchor.constraint(equalTo: masInfoView.centerYAnchor).isActive = true
//
//        popup.center = CGPoint(x: mapBox.frame.width/2, y: mapBox.frame.height/2)
//
//        return popup
//    }
//
//    func showPopup(_ shouldShow: Bool, animated: Bool) {
//        guard let popup = self.popup else {
//        return
//        }
//
//        if shouldShow {
//        view.addSubview(popup)
//        }
//
//        let alpha: CGFloat = (shouldShow ? 1 : 0)
//
//        let animation = {
//        popup.alpha = alpha
//        }
//
//        let completion = { (_: Bool) in
//        if !shouldShow {
//        popup.removeFromSuperview()
//        }
//        }
//
//        if animated {
//        UIView.animate(withDuration: 0.25, animations: animation, completion: completion)
//        } else {
//        animation()
//        completion(true)
//        }
//    }
//
//    @objc
//    func goToDetalle(_ sender: MasInfoButton){
//        LugarDetailRouter().goToLugarDetail(navigationController: self.navigationController, idLugar: sender.id)
//    }
//
//    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
//
//        if annotation is MGLUserLocation {
//
//            let av = MGLUserLocationAnnotationView(annotation: annotation, reuseIdentifier: "")
//            let container = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//            container.backgroundColor = UIColor.clear
//
//
//            let sceneView: SCNView = SCNView(frame: container.frame)
//            sceneView.backgroundColor = UIColor.clear
//            let walking: SCNScene = SCNScene(named: Usuario.shared.getAvatarActivoWalking())!
//            sceneView.scene = walking
//            sceneView.loops = true
//            sceneView.isPlaying = true
//
//            let omniLightNode = SCNNode()
//            omniLightNode.light = SCNLight()
//            omniLightNode.light!.type = .omni
//            omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
//            omniLightNode.position = SCNVector3Make(0, 300, 200)
//            walking.rootNode.addChildNode(omniLightNode)
//
//            container.addSubview(sceneView)
//
//
//            av.addSubview(container)
//            av.frame = container.frame
//            return av
//
//        }
//        return nil
//    }
//
//}
//
//extension MapaViewController: UIGestureRecognizerDelegate{
//    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        // This will only get called for the custom double tap gesture,
//        // that should always be recognized simultaneously.
//        return true
//    }
//
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        // This will only get called for the custom double tap gesture.
//        return firstCluster(with: gestureRecognizer) != nil
//    }
//}
