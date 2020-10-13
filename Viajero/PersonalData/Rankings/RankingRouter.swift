//
//  RankingRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 28/01/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class RankingRouter{
    
    func goToRanking(navigationController: UINavigationController?){
        if let navigation = navigationController{
            let storyboard = UIStoryboard.init(name: "Ranking", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "rankingStoryboard") as! RankingViewController
            let presenter = RankingPresenter()
            presenter.delegate = vc
            vc.presenter = presenter
            navigation.pushViewController(vc, animated: false)
        }
    }
    
}
