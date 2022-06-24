//
//  MapaViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 05/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import SceneKit
import MapboxMaps


//class MapaViewController: BaseViewController, MGLMapViewDelegate{
//
//
//    @IBOutlet var filtrosCollection: UICollectionView!
//    @IBOutlet var filtrosView: UIView!
//    @IBOutlet var rightMenu: RightBarMenu!
//    //@IBOutlet var mapBox: MGLMapView!
//
//    @IBOutlet weak var mapBox: MapView!
//    @IBOutlet weak var avatar: SCNView!
//    @IBOutlet weak var locationButton: UIButton!
//    @IBOutlet weak var avatar_view: CircularProgressView!
//    @IBOutlet weak var nivelView: UIView!
//    @IBOutlet weak var nivelLabel: UILabel!
//
//
//    var duration: TimeInterval!
//
//    var interactor: LugaresInteractor?
//    var presenter: MapaPresenter!
//
//    var firstTime: Bool = true
//    var locationManager: LocationManager = LocationManager.sharedInstance()
//    var userPinView: MKAnnotationView!
//    var lastLocation: CLLocation?
//
//    var canAskForLogros: Bool = true
//
//    var filtrosList: [FiltroCategoriaModel] = []
//
//
//    var iconoPin = UIImage(named: "pin_gris_image")
//    var visitadoPin = UIImage(named: "flag")
//    var popup: UIView?
//    var verde: Style?
//    var azul: Style?
//    var amarillo: Style?
//    var naranja: Style?
//    var rojo: Style?
//    var visitado: Style?
//
//    override func viewDidLoad() {
//        if #available(iOS 13.0, *){
//            overrideUserInterfaceStyle = .light
//        }
//        setUpView()
//
//    }
//
//    func setUpView(){
//        rightMenu.configure(delegate: self, from: self)
//        presenter?.fillFiltros()
//        filtrosCollection.backgroundColor = UIColor.clear
//
//        locationButton.layer.cornerRadius = 25
//        locationButton.layer.borderWidth = 2
//        locationButton.layer.borderColor = UIColor.white.cgColor
//        locationButton.backgroundColor = UIColor.white
//        locationButton.addShadowInContainerView(withRadius: 25)
//
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatar_clicked))
//        avatar_view.isUserInteractionEnabled = true
//        avatar_view.addGestureRecognizer(tap)
//    }
//
//    func initMap(location: CLLocationCoordinate2D){
//
//        let camera = MGLMapCamera()
//        camera.centerCoordinate = location
//        camera.pitch = 45.0
//        camera.altitude = 500.0
//        camera.heading = 45.0
//
//        //Setup our Map View
//        mapBox.delegate = self
////        mapBox.mapType = MKMapType.standard
////        mapBox.showsBuildings = true // displays buildings
////        mapBox.showsCompass = false// esconder la brujula
////        mapBox.showsPointsOfInterest = false //esconder los sitios de interes
//        mapBox.ornaments.compassView.isHidden = true
//        mapBox.ornaments.logoView.isHidden = true
//        //mapBox.attributionButton.isHidden = true
//        mapBox.showsUserLocation = true
//        mapBox.camera = camera
//
//        addGestureRecognizers()
//    }
//
//    func addGestureRecognizers(){
//        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapCluster(sender:)))
//        doubleTap.numberOfTapsRequired = 2
//        doubleTap.delegate = self
//
//        for recognizer in mapBox.gestureRecognizers!
//        where (recognizer as? UITapGestureRecognizer)?.numberOfTapsRequired == 2 {
//        recognizer.require(toFail: doubleTap)
//        }
//        mapBox.addGestureRecognizer(doubleTap)
//
//        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
//        for recognizer in mapBox.gestureRecognizers! where recognizer is UITapGestureRecognizer {
//        singleTap.require(toFail: recognizer)
//        }
//        mapBox.addGestureRecognizer(singleTap)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        locationManager.startTrackingLocation(delegado: self)
//        self.updatePuntos()
//
//        let bigAvatar: SCNScene = SCNScene(named: Usuario.shared.getAvatarActivoStanding())!
//        avatar.present(bigAvatar, with: .fade(withDuration: 0.05), incomingPointOfView: nil)
//        avatar.loops = false
//        avatar.isPlaying = false
//
//        let omniLightNode = SCNNode()
//        omniLightNode.light = SCNLight()
//        omniLightNode.light!.type = .omni
//        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
//        omniLightNode.position = SCNVector3Make(0, 300, 200)
//        bigAvatar.rootNode.addChildNode(omniLightNode)
//
//        nivelView.addShadowInContainerView(withRadius: 25)
//
//        if !firstTime{//para refrescar el pin-avatar en caso de averlo cambiado en camerinos
//            mapBox.showsUserLocation = false
//            mapBox.showsUserLocation = true
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        locationManager.stopTrackingLocation()
//    }
//
//    func isThereAnyLogro(idLugar: String){
//        if canAskForLogros{
//            canAskForLogros = false
//            LogroWorker().askForLogros(lugar: idLugar, delegate: self)
//        }
//    }
//
//    @IBAction func userLocationClicked(_ sender: UIButton) {
//        if let location = self.lastLocation{
//            initMap(location: location.coordinate)
//        }
//    }
//
//    @objc
//    func avatar_clicked(){
//        PersonalDataRouter().goToPersonalData(navigationController: self.navigationController)
//    }
//
//    func updatePuntos() {
//        nivelLabel.text = Usuario.shared.getNivel()
//        avatar_view.setProgressWithAnimation(duration: 2, value:Usuario.shared.getNivelPorcentaje())
//    }
//
//}
//
//extension MapaViewController: LocationManagerProtocol{
//    func locationUpdated(location: CLLocation?) {
//        self.lastLocation = location
//        if firstTime{
//            if let sitio = location {
//                interactor?.getLugares()
//            }
//        } else {
//            LocationManager().isLocatedInLugar(location: location, delegate: self)
//        }
//
//    }
//
//    func noLocatedInLugar(location: CLLocation?) {
//        return
//    }
//
//    func locatedInLugar(lugar: Lugar) {
//        isThereAnyLogro(idLugar: lugar._id ?? "-1")
//    }
//
//}
//
//extension MapaViewController: LogroWorkerProtocol{
//    func logroSuccess(logros: [Logro], lugar: String) {
//        canAskForLogros = true
//        LogrosRouter().goToLogros(navigationController: self.navigationController, logros: logros, lugar: lugar)
//    }
//
//    func logroFail() {
//        canAskForLogros = true
//        return//si no hay logros no hacemos nada
//    }
//
//}
//
//extension MapaViewController: LugaresInteractorProtocol{
//
//    func lugaresReceived(lugares: [Lugar]) {
//
//
//        //SI ES LA PRIMERA VEZ COLOCAR EL MAPA EN LA ULTIMA LOCALIZACION
//        if let location = self.lastLocation, firstTime{
//            initMap(location: location.coordinate)
//        }
//        addGestureRecognizers()
//
//        //CREAR NUEVO ARCHIVO GEOJSON
//        if Lugares.shared.existFileLugaresGJ(){
//            Lugares.shared.removeGeoJSONFile()
//        }
//        Lugares.shared.createGeoJSONFile(lugares: lugares)
//        Lugares.shared.readGeoJSONFile()
//
//        if let _ = mapBox.style?.layer(withIdentifier: "verde"){
//            //BORRAR LAYERS ANTERIORES
//            if let verdeLayer = mapBox.style?.layer(withIdentifier: "verde"){mapBox.style?.removeLayer(verdeLayer)}
//            if let azulLayer = mapBox.style?.layer(withIdentifier: "azul"){mapBox.style?.removeLayer(azulLayer)}
//            if let amarilloLayer = mapBox.style?.layer(withIdentifier: "amarillo"){mapBox.style?.removeLayer(amarilloLayer)}
//            if let naranjaLayer = mapBox.style?.layer(withIdentifier: "naranja"){mapBox.style?.removeLayer(naranjaLayer)}
//            if let rojoLayer = mapBox.style?.layer(withIdentifier: "rojo"){mapBox.style?.removeLayer(rojoLayer)}
//            if let visitadoLayer = mapBox.style?.layer(withIdentifier: "visitado"){mapBox.style?.removeLayer(visitadoLayer)}
//            if let circleLayer = mapBox.style?.layer(withIdentifier: "clusteredCircles"){mapBox.style?.removeLayer(circleLayer)}
//            if let circleNumberLayer = mapBox.style?.layer(withIdentifier: "clusteredCircleNumbers"){mapBox.style?.removeLayer(circleNumberLayer)}
//
//            //BORRAR SOURCE
//            if let pinSource = mapBox.style?.source(withIdentifier: "lugaresPins"){mapBox.style?.removeSource(pinSource)}
//
//            //CREAR NUEVOS LAYERS
//            addPinLayer()
//        }
//
//
//        //preguntar por premio de bienvenida
//        if firstTime {
//            //la primera vez que se llama a la app se llama a askForLogros pasandole lugar -1 para diferenciar
//            isThereAnyLogro(idLugar: "-1")
//            firstTime = false
//        }
//
//
//    }
//
//    func failGettingLugares() {
////        AvisosRouter().goToAvisoStandard(
////            navigationController: self.navigationController,
////            mensaje: "Para poder ver los lugares tienes que tener conexión a internet por lo menos la primera vez!!",
////            okMessage: "Entendido"){
////                return
////        }
//    }
//}
//
//extension MapaViewController: RightBarMenuProtocol {
//    func updateTipoLugares(tipoFiltros: [TipoLugar]) {
//        FiltrosManager.shared.setFiltros(categoriaFiltros: FiltrosManager.shared.categoriaFiltros, tipoLugaresFiltros: tipoFiltros)
//        self.interactor?.getLugares()
//    }
//
//    func filterClicked(){
//        self.openFiltros()
//    }
//}
