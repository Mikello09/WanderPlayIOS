//
//  MapaRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 05/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class MapaRouter{
    
    func goToMapa(navigationController: UINavigationController?, inModoSinConexion: Bool){
        
        if let nv = navigationController{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mapaViewController") as! MapaViewController
            let presenter = MapaPresenter()
            presenter.modoSinConexion = inModoSinConexion
            //presenter.userDataDelegate = vc
            presenter.mapaFiltrosDelegate = vc
            let interactor = LugaresInteractor()
            interactor.delegate = vc
            vc.interactor = interactor
            vc.presenter = presenter
            nv.pushViewController(vc, animated: false)
        }
        
    }
    
}
