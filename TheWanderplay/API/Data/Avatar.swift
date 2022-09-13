//
//  Avatar.swift
//  Viajero
//
//  Created by Mikel Lopez on 08/09/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


struct AvatarModelo: Codable{
    var avatares: [Avatar]?
}

struct Avatar: Codable {
    var nombre: String?
    var descripcion: String?
    var categorias: [String]?
    var precio: Int?
    var nivel: Int?
    
    func getWalking() -> String{
        switch self.nombre {
        case "Playero":
            return "Playero_Walking.scn"
        case "Militar":
            return "LaMilitar_Walking.scn"
        case "Inspector":
            return "Inspector_Walking.scn"
        case "Futbolista":
            return "Futbolista_Walking.scn"
        case "Enfermero":
            return "Enfermero_Walking.scn"
        default:
            return "Playero_Walking.scn"
        }
    }
    
    func getStanding() -> String{
        switch self.nombre {
        case "Playero":
            return "Playero_Standing.scn"
        case "Militar":
            return "LaMilitar_Standing.scn"
        case "Inspector":
            return "Inspector_Standing.scn"
        case "Futbolista":
            return "Futbolista_Standing.scn"
        case "Enfermero":
            return "Enfermero_Standing.scn"
        default:
            return "Playero_Standing.scn"
        }
    }
    
    func getDancing() -> String{
        switch self.nombre {
        case "Playero":
            return "Playero_Standing.scn"
        case "Militar":
            return "LaMilitar_Dancing.scn"
        case "Inspector":
            return "Inspector_Dancing.scn"
        case "Futbolista":
            return "Futbolista_Dancing.scn"
        case "Enfermero":
            return "Enfermero_Dancing.scn"
        default:
            return "Playero_Standing.scn"
        }
    }
    
    func getTipoCategorias() -> [Categoria]{
        var tipoCategorias: [Categoria] = []
        guard let categorias = self.categorias else {
            return []
        }
        for categoria in categorias{
            switch categoria {
                case "castillos":
                    tipoCategorias.append(.castillos)
                case "iglesia":
                    tipoCategorias.append(.iglesias)
                case "calles":
                    tipoCategorias.append(.calles)
                case "miradores":
                    tipoCategorias.append(.miradores)
                case "monumentos":
                    tipoCategorias.append(.monumentos)
                case "edificios":
                    tipoCategorias.append(.edificios)
                case "pueblos":
                    tipoCategorias.append(.pueblos)
                case "parques":
                    tipoCategorias.append(.parques)
                default:
                    print("nothing to do")
            }
        }
        return tipoCategorias
    }
    
    func getImage() -> String{
        switch self.nombre {
        case "Playero":
            return "playero"
        case "Militar":
            return "militar"
        case "Inspector":
            return "Inspector"
        default:
            return "playero"
        }
    }
}
