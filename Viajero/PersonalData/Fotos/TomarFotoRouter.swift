//
//  TomarFotoRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 07/01/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class TomarFotoRouter{
    
    func goToTomarFoto(navigationController: UINavigationController?){
        
        if let navigation = navigationController{
            let storyboard = UIStoryboard.init(name: "Foto", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "tomarFotoStoryboard") as! TomarFotoViewController
            navigation.pushViewController(vc, animated: false)
        }
        
    }
    
}
