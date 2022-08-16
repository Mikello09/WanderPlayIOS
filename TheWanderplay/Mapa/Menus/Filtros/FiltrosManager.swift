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
    
    var categoriaFiltros: [FiltroCategoriaModel] = []
    var tipoLugaresFiltros: [TipoLugar] = [.bajo, .medio, .alto, .muyAlto, .patrimonio]
    
    func setFiltros(categoriaFiltros: [FiltroCategoriaModel], tipoLugaresFiltros: [TipoLugar]){
        self.categoriaFiltros = categoriaFiltros
        self.tipoLugaresFiltros = tipoLugaresFiltros
    }
    
    func getCategoriasFiltradas() -> [FiltroCategoriaModel]{
        return categoriaFiltros
    }
    
    func getTipoLugaresFiltros() -> [TipoLugar]{
        return tipoLugaresFiltros
    }
    
    func isFiltrosToApply() -> Bool{
        return getCategoriasFiltradas().count > 0 || (getTipoLugaresFiltros().count != 0 && getTipoLugaresFiltros().count < 5)
    }
    
}
