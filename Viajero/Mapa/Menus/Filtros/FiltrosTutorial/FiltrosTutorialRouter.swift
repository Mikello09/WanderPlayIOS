//
//  FiltrosTutorialRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 17/05/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class FiltrosTutorialRouter{
    
    func goToFiltrosTutorial(navigationController: UINavigationController?){
        if let navigation = navigationController{
            
            let storyboard = UIStoryboard(name: "FiltrosTutorial", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "filtrosTutorialStoryBoard") as! FiltrosTutorialViewController
            
            vc.modalPresentationStyle = .overFullScreen
            navigation.present(vc, animated: false, completion: nil)
            
        }
    }
    
}
