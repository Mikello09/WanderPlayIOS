//
//  LoginManualRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 28/08/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


class LoginManualRouter{
    
    
    func goToLoginManual(navigationController: UINavigationController?){
        if let navigation = navigationController{
            let storyboard = UIStoryboard.init(name: "LoginManual", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "loginManualStoryboard") as! LoginManualViewController
            
            let presenter = LoginManualPresenter()
            presenter.delegate = vc
            vc.presenter = presenter
            
            navigation.pushViewController(vc, animated: false)
        }
    }
    
}
