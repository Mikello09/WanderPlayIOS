//
//  PersonalDataRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 08/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class PersonalDataRouter{
    
    func goToPersonalData(navigationController: UINavigationController?){
        if let navigation = navigationController{
            let storyBoard = UIStoryboard.init(name: "PersonalData", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "personalDataStoryBoard") as! PersonalDataViewController
            let presenter = PersonalDataPresenter()
            presenter.delegate = vc
            vc.presenter = presenter
            vc.modalPresentationStyle = .overCurrentContext
            //navigation.present(vc, animated: true, completion: nil)
            navigation.pushViewController(vc, animated: false)
        }
    }
    
    func goToCerrarSesion(fromVC: UIViewController){
        if let navigation = fromVC.navigationController{
            let alert = UIAlertController(title: "Cuidado!!", message: "Si cierras sesión perderás el progreso del juego", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                Usuario.shared.eliminarCredenciales()
                LoginRouter().goToLogin(navigationController: fromVC.navigationController)
            }))
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            fromVC.present(alert, animated: true, completion: nil)
        }
    }
    
}
