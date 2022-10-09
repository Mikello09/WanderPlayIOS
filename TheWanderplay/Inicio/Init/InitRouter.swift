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
    
    func goToInit(navigationController: UINavigationController?) {
        
        let storyboard = UIStoryboard(name: "InitStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "initStoryboard") as? InitViewController else { return }
        
        let presenter = InitPresenter()
        presenter.delegate = vc
        vc.presenter = presenter
        
        if let nv = navigationController {
            nv.pushViewController(vc, animated: false)
        } else {
            let newNavigation = UINavigationController(rootViewController: vc)
            
            guard let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window else { return }
            window.rootViewController = newNavigation
            window.makeKeyAndVisible()
        }
    }
    
}
