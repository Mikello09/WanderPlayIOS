//
//  InitViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 06/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class InitViewController: BaseViewController{
    
    var isCalling: Bool = false
    
    var locationEngine: LocationEngine!
    
    @IBOutlet weak var cargandoView: UIView!
    @IBOutlet weak var earth_imagen: UIImageView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var errorButton: UIButton!
    
    //let reachabilityManager = NetworkReachabilityManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = Float.infinity
        earth_imagen.layer.add(rotationAnimation, forKey: "rotationanimationkey")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationEngine = LocationEngine.sharedInstance()
        locationEngine.startEngineForPermission(delegate: self)
    }
    
    func start(){
        if !self.isCalling{
            self.isCalling = true
            LoginWorker().execute(nombre: Usuario.shared.getNombreCredencial() ?? "",
                                  pass: Usuario.shared.getPassCredencial() ?? "",
                                  delegate: self)
        }
    }
    
    
    @IBAction func errorButtonClicked(_ sender: UIButton) {
        self.errorView.isHidden = true
        self.cargandoView.isHidden = false
        self.isCalling = false
        start()
    }
    
    func configureError(image: String, message: String, intentar: Bool){
        self.cargandoView.isHidden = true
        if intentar{
            errorButton.isHidden = false
            errorButton.setNormalStyle()
        } else {
            errorButton.isHidden = true
        }
        
        errorImage.image = UIImage(named: image)
        errorMessage.text = message
        errorView.isHidden = false
    }
}

extension InitViewController: LocationEnginePermission{
    func accepted() {
        self.errorView.isHidden = true
        self.cargandoView.isHidden = false
        self.start()
    }
    func denied() {
        self.configureError(image: "no_gps", message: "Tienes que activar el gps para poder empezar a jugar!!", intentar: false)
    }
    func notDetermined() {
        self.locationEngine.askPermision()
    }
}

extension InitViewController: LoginWorkerProtocol{
    func success() {
        LugarWorker().execute(delegate: self)
    }
    
    func fail(error: String) {
        self.configureError(image: "no_gps", message: error, intentar: true)
    }
}

extension InitViewController: LugarWorkerProtocol{
    func successLugares() {
//        MapaRouter().goToMapa(navigationController: self.navigationController, inModoSinConexion: false)
        DispatchQueue.main.async {
            MapRouter().goToMap(navigationController: self.navigationController)
        }
    }
    
    func failLugares(error: String) {
        DispatchQueue.main.async {
            self.configureError(image: "no_gps", message: error, intentar: true)
        }
    }
}
