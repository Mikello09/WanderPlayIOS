//
//  WelcomeRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 29/04/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class WelcomeRouter{
    
    func goToWelcome(navigationController: UINavigationController?){
        
        if let navigation = navigationController{
            let storyboard = UIStoryboard.init(name: "Welcome", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "welcomeStoryboard") as! WelcomeViewController
            let presenter = WelcomePresenter()
            presenter.delegate = vc
            vc.presenter = presenter
            navigation.pushViewController(vc, animated: false)
            
        }
    }
    
}
