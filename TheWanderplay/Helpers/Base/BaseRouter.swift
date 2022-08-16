//
//  BaseRouter.swift
//  Viajero
//
//  Created by Mikel Lopez on 15/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


class BaseRouter{
    
    func getTransition() -> CATransition{
        let transition:CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        return transition
    }
    
}
