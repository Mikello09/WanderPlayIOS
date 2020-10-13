//
//  ChooseAvatarRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 01/05/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class ChooseAvatarRouter{
    
    func goToChooseAvatar(navigationController: UINavigationController?, nombre: String?, pass: String?){
        
        if let navigation = navigationController{
            let storyboard: UIStoryboard = UIStoryboard(name: "ChooseAvatar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "chooseAvatarStoryboard") as! ChooseAvatarViewController
            vc.nombre = nombre
            vc.pass = pass
            let presenter = ChooseAvatarPresenter()
            presenter.delegate = vc
            vc.presenter = presenter
            navigation.pushViewController(vc, animated: false)
        }
        
    }
    
}
