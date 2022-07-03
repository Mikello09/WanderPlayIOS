//
//  MapRouter.swift
//  Viajero
//
//  Created by Mikel Lopez Salazar on 24/6/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class MapRouter {
    
    func goToMap(navigationController: UINavigationController?) {
        if let navigationController = navigationController {
            let storyboard = UIStoryboard(name: "MapStoryboard", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "mapStoryboard") as? MapViewController else { return }
            let presenter = MapPresenter()
            presenter.delegate = vc
            vc.presenter = presenter
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
}
