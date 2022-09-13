//
//  FiltrosManager.swift
//  Viajero
//
//  Created by Mikel Lopez on 06/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class FiltrosManager{
    
    static var shared = FiltrosManager()
    
    var categoriaFiltros: [Categoria] = []
    var interesFiltros: [Interes] = [.bajo, .medio, .alto, .muyAlto, .patrimonio]
    
    func setInteresFiltros(interesFiltros: [Interes]) {
        self.interesFiltros = interesFiltros
    }
    
    func setCategoriaFiltros(categoriaFiltros: [Categoria]) {
        self.categoriaFiltros = categoriaFiltros
    }
    
    func getCategoriasFiltradas() -> [Categoria]{
        return categoriaFiltros
    }
    
    func getInteresFiltros() -> [Interes]{
        return interesFiltros
    }
    
    func isFiltrosToApply() -> Bool{
        return getCategoriasFiltradas().count > 0 || (getInteresFiltros().count != 0 && getInteresFiltros().count < 5)
    }
    
}
