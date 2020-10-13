//
//  InitRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 06/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


class InitRouter{
    
    func goToInit(navigationController: UINavigationController?){
        
        if let nv = navigationController{
            let storyboard = UIStoryboard(name: "Init", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "initViewController") as! InitViewController
            nv.pushViewController(vc, animated: false)
        }
    }
    
}
