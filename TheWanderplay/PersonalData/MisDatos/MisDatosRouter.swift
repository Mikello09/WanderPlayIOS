//
//  MisDatosRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 09/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class MisDatosRouter{
    
    func goToMisDatos(navigationController: UINavigationController?){
        if let navigation = navigationController{
            let storyboard = UIStoryboard.init(name: "MisDatos", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "misDatosStoryboard") as! MisDatosViewController
            let presenter = MisDatosPresenter()
            presenter.delegate = vc
            vc.presenter = presenter
            navigation.pushViewController(vc, animated: true)
            
        }
    }
    
}
