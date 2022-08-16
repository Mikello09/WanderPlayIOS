//
//  PasaporteRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 05/12/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class PasaporteRouter{
    
    func goToPasaporte(navigationController: UINavigationController?){
        if let navigation = navigationController{
            let storyboard = UIStoryboard.init(name: "Pasaporte", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "pasaporteStoryboard") as! PasaporteViewController
            let presenter = PasaportePresenter()
            presenter.delegate = vc
            vc.presenter = presenter
            navigation.pushViewController(vc, animated: false)
            
        }
    }
    
}
