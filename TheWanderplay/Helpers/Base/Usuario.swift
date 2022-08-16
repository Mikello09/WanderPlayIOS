//
//  Usuario.swift
//  Viajero
//
//  Created by Mikel Lopez on 28/08/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

struct UsuarioModelo: Codable{
    var usuario: UsuarioModel?
}

struct UsuarioModel: Codable{
    var nombre: String?
    var apellidos: String?
    var email: String?
    var direccion: String?
    var pais: String?
    var provincia: String?
    var ciudad: String?
    var edad: Int?
    var puntos: Int?
    var contrasena: String?
    var ultimoIngreso: String?
    var version: String?
    var monedas: Int?
    var diamantes: Int?
    var avatarActivo: String?
    var avatares: [String]?
    var lugares: [String]?
    
    func getNivel() -> String{
        if let puntos = self.puntos{
            if puntos >= 0 && puntos <= 999{
                return "1"
            }
            if puntos > 999 && puntos <= 1999{
                return "2"
            }
            if puntos > 1999 && puntos <= 4999{
                return "3"
            }
            if puntos > 4999 && puntos <= 7499{
                return "4"
            }
            if puntos > 7499 && puntos <= 12499{
                return "5"
            }
        }
        return "0"
    }
}


class Usuario{
    
    static var shared = Usuario()
    
    var nombre: String = ""
    var apellidos: String = ""
    var email: String = ""
    var direccion: String = ""
    var pais: String = ""
    var provincia: String = ""
    var ciudad: String = ""
    var edad: Int = 0
    var puntos: Int = 0
    var contrasena: String = ""
    var ultimoIngreso: String = ""
    var version: String = ""
    var monedas: Int = 0
    var diamantes: Int = 0
    var avatarActivo: String = ""
    var avatares: [String] = []
    var lugares: [String] = []
    
    
    func guardarUsuario(usuario: UsuarioModel?){
        if let usuario = usuario{
            Usuario.shared.nombre = usuario.nombre ?? ""
            Usuario.shared.apellidos = usuario.apellidos ?? ""
            Usuario.shared.email = usuario.email ?? ""
            Usuario.shared.direccion = usuario.direccion ?? ""
            Usuario.shared.pais = usuario.pais ?? ""
            Usuario.shared.provincia = usuario.provincia ?? ""
            Usuario.shared.ciudad = usuario.ciudad ?? ""
            Usuario.shared.edad = usuario.edad ?? 0
            Usuario.shared.puntos = usuario.puntos ?? 0
            Usuario.shared.contrasena = usuario.contrasena ?? ""
            Usuario.shared.ultimoIngreso = usuario.ultimoIngreso ?? ""
            Usuario.shared.version = usuario.version ?? ""
            Usuario.shared.monedas = usuario.monedas ?? 0
            Usuario.shared.diamantes = usuario.diamantes ?? 0
            Usuario.shared.avatarActivo = usuario.avatarActivo ?? ""
            Usuario.shared.avatares = usuario.avatares ?? []
            Usuario.shared.lugares = usuario.lugares ?? []
        }
    }
    
    func guardarCredenciales(nombre: String, pass: String){
        UserDefaults.standard.set(nombre, forKey: "nombre")
        UserDefaults.standard.set(pass, forKey: "pass")
    }
    
    func getNombreCredencial() -> String?{
        return UserDefaults.standard.string(forKey: "nombre")
    }
    
    func getPassCredencial() -> String?{
        return UserDefaults.standard.string(forKey: "pass")
    }
    
    func eliminarCredenciales(){
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    func getNivel() -> String{
        let puntos = self.puntos
        if puntos >= 0 && puntos <= 999{
            return "1"
        }
        if puntos > 999 && puntos <= 1999{
            return "2"
        }
        if puntos > 1999 && puntos <= 4999{
            return "3"
        }
        if puntos > 4999 && puntos <= 7499{
            return "4"
        }
        if puntos > 7499 && puntos <= 12499{
            return "5"
        }
        return "0"
    }
    
    func getNivelPorcentaje() -> Float{
        switch self.getNivel() {
        case "1":
            return Float(1 - ((999 - 0) - (Float(self.puntos) - 0))/(999 - 0))
        case "2":
            return Float(1 - ((1999 - 999) - (Float(self.puntos) - 999))/(1999 - 999))
        case "3":
            return Float(1 - ((4999 - 1999) - (Float(self.puntos) - 1999))/(4999 - 1999))
        case "4":
            return Float(1 - ((7499 - 4999) - (Float(self.puntos) - 4999))/(7499 - 4999))
        case "5":
            return Float(1 - ((12499 - 7499) - (Float(self.puntos) - 7499))/(12499 - 7499))
        default:
            return 0
        }
    }
    
    func getAvatarActivoWalking() -> String{
        switch self.avatarActivo {
        case "Playero":
            return "Playero_Walking.scn"
        case "Militar":
            return "LaMilitar_Walking.scn"
        case "Inspector":
            return "Inspector_Walking.scn"
        default:
            return "Playero_Walking.scn"
        }
    }
    
    func getAvatarActivoStanding() -> String{
        switch self.avatarActivo {
        case "Playero":
            return "Playero_Standing.scn"
        case "Militar":
            return "LaMilitar_Standing.scn"
        case "Inspector":
            return "Inspector_Standing.scn"
        default:
            return "Playero_Standing.scn"
        }
    }
    
    func getAvatarActivoDancing() -> String{
        switch self.avatarActivo {
        case "Playero":
            return "Playero_Standing.scn"
        case "Militar":
            return "LaMilitar_Dancing.scn"
        case "Inspector":
            return "Inspector_Dancing.scn"
        default:
            return "Playero_Standing.scn"
        }
    }
    
}
