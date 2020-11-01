//
//  LogrosPresenter.swift
//  Viajero
//
//  Created by Mikel Lopez on 14/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol LogrosPresenterProtocol {
    func paintLugarImagen(imagen: String)
    func paintTitle(title: String)
    func showError()
}

class LogrosPresenter{
    
    var delegate: LogrosPresenterProtocol?
    var lugarId: String = "-1"
    
    func getLugarImage(){
        LugaresManager.shared.getLugares(delegate: self)
    }
    
    func updateUsuario(){
        if lugarId != "-1"{
            Usuario.shared.lugares.append(lugarId)
        }
    }
    
}

extension LogrosPresenter: LugaresManagerProtocol{
    func lugaresUpdated(lugares: [Lugar]?) {
        if let lugares = lugares{
            for lugar in lugares where lugar._id == lugarId{
                delegate?.paintLugarImagen(imagen: lugar.foto1 ?? "")
                delegate?.paintTitle(title: "\(lugar.nombre ?? "")")
                return
            }
            delegate?.paintTitle(title: "Bienvenido!!")
            delegate?.paintLugarImagen(imagen: "lugar_bienvenida")
        } else {
            delegate?.showError()
        }
    }
    
    func failGettingLugares() {
        delegate?.showError()
    }
    
    
}
