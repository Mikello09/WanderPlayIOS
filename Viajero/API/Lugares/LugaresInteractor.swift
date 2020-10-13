//
//  LugaresInteractor.swift
//  Viajero
//
//  Created by Mikel Lopez on 04/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


protocol LugaresInteractorProtocol{
    func lugaresReceived(lugares: [Lugar])
    func failGettingLugares()
}


class LugaresInteractor{
    
    var delegate: LugaresInteractorProtocol?
    
    func getLugares(){
        LugaresManager.shared.getLugares(delegate: self)
    }
    
}

extension LugaresInteractor: LugaresManagerProtocol{
    func failGettingLugares() {
        delegate?.failGettingLugares()
    }
    
    func lugaresUpdated(lugares: [Lugar]?) {
        guard let lugares = lugares else {
            delegate?.failGettingLugares()
            return
        }
        delegate?.lugaresReceived(lugares: lugares)
    }
}
