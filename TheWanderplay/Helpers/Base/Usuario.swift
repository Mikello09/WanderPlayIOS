//
//  Usuario.swift
//  Viajero
//
//  Created by Mikel Lopez on 28/08/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

struct LoginModel: Codable {
    var settings: Settings
    var usuario: UsuarioModel
}

struct Settings: Codable {
    var lugaresCreateDate: String
}

struct UsuarioModel: Codable{
    var nombre: String
    var apellidos: String?
    var email: String
    var direccion: String?
    var pais: String?
    var provincia: String?
    var ciudad: String?
    var edad: Int?
    var puntos: Int?
    var nivel: Int?
    var contrasena: String
    var ultimoIngreso: String?
    var version: String?
    var monedas: Int?
    var diamantes: Int?
    var avatarActivo: String?
    var avatares: [String]?
    var lugares: [String]?
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
    var nivel: Int = 1
    var contrasena: String = ""
    var ultimoIngreso: String?
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
            Usuario.shared.nivel = usuario.nivel ?? 1
            Usuario.shared.contrasena = usuario.contrasena ?? ""
            Usuario.shared.ultimoIngreso = usuario.ultimoIngreso
            Usuario.shared.version = usuario.version ?? ""
            Usuario.shared.monedas = usuario.monedas ?? 0
            Usuario.shared.diamantes = usuario.diamantes ?? 0
            Usuario.shared.avatarActivo = usuario.avatarActivo ?? ""
            Usuario.shared.avatares = usuario.avatares ?? []
            Usuario.shared.lugares = usuario.lugares ?? []
        }
    }
    
    func guardarCredenciales(nombre: String, pass: String) {
        UserDefaults.standard.set(nombre, forKey: "nombre")
        UserDefaults.standard.set(pass, forKey: "pass")
    }
    
    func getNombreCredencial() -> String? {
        return UserDefaults.standard.string(forKey: "nombre")
    }
    
    func getPassCredencial() -> String? {
        return UserDefaults.standard.string(forKey: "pass")
    }
    
    func eliminarCredenciales() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    func getNivelPorcentaje() -> Float {
        let baseLevel: CGFloat = 999
        let factor: CGFloat = 0.2
        
        var beforeLevel: CGFloat = 0
        if nivel > 1 {
            beforeLevel = ((CGFloat(nivel - 1)*baseLevel) + (CGFloat(nivel)*factor*baseLevel))
        }
        let nextLevel = (CGFloat(nivel)*baseLevel) + (CGFloat(nivel - 1)*factor*baseLevel)
        
        return Float((CGFloat(puntos) - beforeLevel)/(nextLevel - beforeLevel))
    }
    
    func getAvatarActivoWalking() -> String {
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
    
    func getAvatarActivoStanding() -> String {
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
    
    func getAvatarActivoDancing() -> String {
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
