//
//  LoginRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 18/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter{
    
    func goToLogin(navigationController: UINavigationController?){
        
        if let navigation = navigationController{
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            if let vc = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as? LoginViewController{
                navigation.pushViewController(vc, animated: true)
            }
        }
        
    }
    
}
