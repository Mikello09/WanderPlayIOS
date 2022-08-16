//
//  PersonalDataPresenter.swift
//  Viajero
//
//  Created by Mikel Lopez on 08/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

enum DayMoment{
    case dia
    case tarde
    case noche
}

protocol PersonalDataProtocol {
    func setItems(items: [PersonalDataCollectionItem])
}

class PersonalDataPresenter{
    
    var delegate: PersonalDataProtocol?
    
    func getItems(){
        delegate?.setItems(items: [
            .ranking,
            .galeria,
            .tomarFoto,
            .miPerfil,
            .pasaporte,
            .tienda,
            .ajustes,
            .cerrarSesion
        ])
    }
}
