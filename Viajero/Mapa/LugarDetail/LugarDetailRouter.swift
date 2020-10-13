//
//  LugarDetailRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 25/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class LugarDetailRouter{
    
    func goToLugarDetail(navigationController: UINavigationController?, idLugar: String){
        
        if let navigation = navigationController{
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "lugarDetailStoryBoard") as! LugarDetailViewController
            
            let presenter = LugarDetailPresenter()
            presenter.idLugar = idLugar
            presenter.delegate = vc
            vc.presenter = presenter
            
            
            vc.modalPresentationStyle = .overFullScreen
            navigation.present(vc, animated: false, completion: nil)
            
            //navigation.pushViewController(vc, animated: false)
        }
        
    }
    
}
