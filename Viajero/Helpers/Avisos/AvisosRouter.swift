//
//  AvisosRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 29/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class AvisosRouter{
    
    func goToAvisoStandard(navigationController: UINavigationController?,
                           titulo: String,
                           mensaje: String,
                           okAction: @escaping() -> ()){
        if let navigation = navigationController{
            let vc = configureViewController(avisoModel: AvisoModel(
                tipo: .standar,
                titulo: titulo,
                mensaje: mensaje,
                acceptAction: okAction))
            vc.modalPresentationStyle = .overFullScreen
            navigation.present(vc, animated: false, completion: nil)
        }
    }
    
    func configureViewController(avisoModel: AvisoModel) -> UIViewController{
        let storyBoard = UIStoryboard.init(name: "Avisos", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "avisosStoryBoard") as! AvisosViewController
        let presenter = AvisosPresenter()
        presenter.aviso = avisoModel
        presenter.delegate = vc
        vc.presenter = presenter
        return vc
        
    }
}
