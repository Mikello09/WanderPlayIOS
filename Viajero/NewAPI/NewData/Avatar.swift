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
            return "Playero_Walking"
        case "Militar":
            return "LaMilitar_Walking"
        case "Inspector":
            return "Inspector_Walking"
        case "Futbolista":
            return "Futbolista_Walking"
        case "Enfermero":
            return "Enfermero_Walking"
        default:
            return "Playero_Walking"
        }
    }
    
    func getStanding() -> String{
        switch self.nombre {
        case "Playero":
            return "Playero_Standing"
        case "Militar":
            return "LaMilitar_Standing"
        case "Inspector":
            return "Inspector_Standing"
        case "Futbolista":
            return "Futbolista_Standing"
        case "Enfermero":
            return "Enfermero_Standing"
        default:
            return "Playero_Standing"
        }
    }
    
    func getDancing() -> String{
        switch self.nombre {
        case "Playero":
            return "Playero_Standing"
        case "Militar":
            return "LaMilitar_Dancing"
        case "Inspector":
            return "Inspector_Dancing"
        case "Futbolista":
            return "Futbolista_Dancing"
        case "Enfermero":
            return "Enfermero_Dancing"
        default:
            return "Playero_Standing"
        }
    }
    
    func getTipoCategorias() -> [TipoCategorias]{
        var tipoCategorias: [TipoCategorias] = []
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
