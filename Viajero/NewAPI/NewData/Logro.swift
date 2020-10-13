//
//  Logro.swift
//  Viajero
//
//  Created by Mikel Lopez on 12/09/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit



struct GroupedLogros: Codable {
    var Grupo: String = ""
    var Logros: [Logro] = []
}

struct Logro: Codable{
    var _id: String?
    var titulo: String?
    var descripcion: String?
    var imagen: String?
    var puntos: Int?
    var monedas: Int?
    var diamantes: Int?
    var porcentaje: Double?
    var grupo: String?
    var logroToken: String?
}

struct RespuestaLogros: Codable {
    var logros: [Logro]?
}
