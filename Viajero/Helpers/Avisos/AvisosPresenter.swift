//
//  AvisosPresenter.swift
//  Viajero
//
//  Created by Mikel Lopez on 29/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

enum AvisosTipo {
    case standar
}

struct AvisoModel {
    var tipo: AvisosTipo
    var titulo: String
    var mensaje: String
    var acceptMessage: String = ""
    var closeMessage: String = ""
    var acceptAction: (() -> Void)
}

protocol AvisoProtocol{
    func paintView(view: UIView)
    func closeAviso()
}

class AvisosPresenter{
    
    var aviso: AvisoModel?
    
    var delegate: AvisoProtocol?
    
    func setAviso(){
        if let aviso = aviso{
            switch aviso.tipo {
            case .standar:
                let standardView: AvisoStandar = AvisoStandar()
                standardView.translatesAutoresizingMaskIntoConstraints = false
                standardView.configure(
                    titulo: aviso.titulo,
                    mensaje: aviso.mensaje,
                    aceptarAction: aviso.acceptAction,
                    delegate: self)
                delegate?.paintView(view: standardView)
                return
            }
        }
        delegate?.closeAviso()
    }
}

extension AvisosPresenter: AvisoStandardProtocol{
    func closeAviso() {
        delegate?.closeAviso()
    }
}
