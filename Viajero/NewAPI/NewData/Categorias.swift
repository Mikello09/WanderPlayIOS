//
//  Categorias.swift
//  Viajero
//
//  Created by Mikel Lopez on 10/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

enum TipoCategorias: String{
    case castillos = "castillos"
    case iglesias = "iglesias"
    case calles = "calles"
    case miradores = "miradores"
    case monumentos = "monumentos"
    case edificios = "edificios"
    case pueblos = "pueblos"
    case parques = "parques"
    case playas = "playas"
    
    func getTitulos() -> String{
        switch self {
        case .castillos:
            return "Castillos y Palacios"
        case .iglesias:
            return "Iglesias"
        case .calles:
            return "Calles y Plazas"
        case .miradores:
            return "Miradores"
        case .monumentos:
            return "Monumentos"
        case .edificios:
            return "Edificios"
        case .pueblos:
            return "Pueblos"
        case .parques:
            return "Parques"
        case .playas:
            return "Playas"
        }
    }
}

class Categorias{
    
    var titulos: [String] = []
    var imagenes: [String] = []
    
    static var shared = Categorias()
    
    var categorias: [TipoCategorias] = [.castillos,
                                        .iglesias,
                                        .calles,
                                        .miradores,
                                        .monumentos,
                                        .edificios,
                                        .pueblos,
                                        .parques,
                                        .playas]
    
    
    func rellenarCategorias(){
        for categoria in categorias{
            self.titulos.append(categoria.getTitulos())
            self.imagenes.append(categoria.rawValue)
        }
        
    }
    
}
