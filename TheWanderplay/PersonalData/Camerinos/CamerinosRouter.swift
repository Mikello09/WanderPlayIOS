//
//  CamerinosRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 12/09/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


class CamerinosRouter{
    
    func goToCamerinos(navigationController: UINavigationController?){
        if let navigation = navigationController{
            let storyboard = UIStoryboard.init(name: "Camerinos", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "camerinosStoryboard") as! CamerinosViewController
            navigation.pushViewController(vc, animated: false)
        }
    }
    
}
