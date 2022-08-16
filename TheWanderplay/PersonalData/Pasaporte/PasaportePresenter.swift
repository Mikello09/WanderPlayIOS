//
//  PasaportePresenter.swift
//  Viajero
//
//  Created by Mikel Lopez on 05/12/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol PasaportePresenterProtocol{
    func paintLogros(logros: [GroupedLogros])
    func paintError()
    func groupChanged(logros: [Logro])
}

class PasaportePresenter{
    
    var delegate: PasaportePresenterProtocol?
    var allLogros: [GroupedLogros] = []
    
    func getUserLogros(){
        PasaporteWorker().getAllLogros(delegate: self)
    }
    
    func groupChanged(grupo: String){
        for grupos in allLogros{
            if grupos.Grupo == grupo {
                delegate?.groupChanged(logros: grupos.Logros)
            }
        }
    }
    
}

extension PasaportePresenter: PasaporteAllLogrosProtocol{
    func successAllLogros(groupedLogros: [GroupedLogros]) {
        self.allLogros = groupedLogros
        delegate?.paintLogros(logros: groupedLogros)
    }
    
    func failAllLogros() {
        delegate?.paintError()
    }
    
    
}
