//
//  Categorias.swift
//  Viajero
//
//  Created by Mikel Lopez on 10/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

enum Categoria: String {
    case castillos = "Castillos y Palacios"
    case iglesias = "Iglesias"
    case calles = "Calles y Plazas"
    case miradores = "Miradores"
    case monumentos = "Monumentos"
    case edificios = "Edificios"
    case pueblos = "Pueblos"
    case parques = "Parques"
    case playas = "Playas"
    case naturaleza = "Naturaleza"
    case fuentes = "Fuentes"
    
    func getTitulo() -> String {
        switch self {
        case .castillos: return "Castillos y Palacios"
        case .iglesias: return "Iglesias"
        case .calles: return "Calles y Plazas"
        case .miradores: return "Miradores"
        case .monumentos: return "Monumentos"
        case .edificios: return "Edificios"
        case .pueblos: return "Pueblos"
        case .parques: return "Parques"
        case .playas: return "Playas"
        case .naturaleza: return "Naturaleza"
        case .fuentes: return "Fuentes"
        }
    }
    
    func getImagen() -> UIImage? {
        switch self {
        case .castillos: return UIImage(named: "castillos")
        case .iglesias: return UIImage(named: "iglesias")
        case .calles: return UIImage(named: "calles")
        case .miradores: return UIImage(named: "miradores")
        case .monumentos: return UIImage(named: "monumentos")
        case .edificios: return UIImage(named: "edificios")
        case .pueblos: return UIImage(named: "pueblos")
        case .parques: return UIImage(named: "parques")
        case .playas: return UIImage(named: "playas")
        case .naturaleza: return UIImage(named: "naturaleza")
        case .fuentes: return UIImage(named: "fuentes")
        }
    }
}

class CategoriasManager {
    
    static var shared = CategoriasManager()
    
    var categorias: [Categoria] = [.castillos,
                                    .iglesias,
                                    .calles,
                                    .miradores,
                                    .monumentos,
                                    .edificios,
                                    .pueblos,
                                    .parques,
                                    .playas,
                                    .naturaleza,
                                    .fuentes]
    
    var activeCategorias: [Categoria] = [.castillos,
                                        .iglesias,
                                        .calles,
                                        .miradores,
                                        .monumentos,
                                        .edificios,
                                        .pueblos,
                                        .parques,
                                        .playas,
                                        .naturaleza,
                                        .fuentes]
    
    func categoriaSelected(categoria: Categoria) {
        if let indexToRemove = activeCategorias.firstIndex(of: categoria) {
            activeCategorias.remove(at: indexToRemove)
        } else {
            activeCategorias.append(categoria)
        }
    }
    
    func isCategoriaActive(categoria: Categoria) -> Bool {
        return activeCategorias.contains(categoria)
    }
}
