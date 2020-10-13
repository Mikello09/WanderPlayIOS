//
//  LogrosRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 14/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


class LogrosRouter: BaseRouter{
    
    func goToLogros(navigationController: UINavigationController?, logros: [Logro], lugar: String){
        if let navigation = navigationController{
            let storyBoard = UIStoryboard.init(name: "Logros", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "logrosViewController") as! LogrosViewController
            let presenter = LogrosPresenter()
            presenter.lugarId = lugar
            presenter.delegate = vc
            vc.logros = logros
            vc.presenter = presenter
            navigation.pushViewController(vc, animated: false)
        }
    }
    
}
