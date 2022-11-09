//
//  WanderplayBBDD.swift
//  TheWanderplay
//
//  Created by Mikel Lopez Salazar on 6/11/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class UsuarioBBDD {
    
    static func saveUsuario(usuario: UsuarioModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "UsuarioEntity", in: context) else { return }
        let newUser = NSManagedObject(entity: entity, insertInto: context)
        
        newUser.setValue(usuario.nombre, forKey: "nombre")
        newUser.setValue(usuario.contrasena, forKey: "contrasena")
        newUser.setValue(usuario.apellidos, forKey: "apellidos")
        newUser.setValue(usuario.email, forKey: "email")
        newUser.setValue(usuario.direccion, forKey: "direccion")
        newUser.setValue(usuario.ciudad, forKey: "ciudad")
        newUser.setValue(usuario.provincia, forKey: "provincia")
        newUser.setValue(usuario.pais, forKey: "pais")
        newUser.setValue(usuario.ultimoIngreso, forKey: "ultimoIngreso")
        newUser.setValue(usuario.nivel, forKey: "nivel")
        newUser.setValue(usuario.puntos, forKey: "puntos")
        newUser.setValue(usuario.monedas, forKey: "monedas")
        newUser.setValue(usuario.diamantes, forKey: "diamantes")
        
        do {
            try context.save()
         } catch {
          print("Error saving user: \(error)")
        }
    }
    
    static func getUsuario() -> UsuarioModel? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UsuarioEntity")
        //request.predicate = NSPredicate(format: "age = %@", "21")
        request.returnsObjectsAsFaults = false
        
        guard let bbddObject = try? context.fetch(request).first as? NSManagedObject else { return nil }
        
        if
            let nombre = bbddObject.value(forKey: "nombre") as? String,
            let contrasena = bbddObject.value(forKey: "contrasena") as? String,
            let email = bbddObject.value(forKey: "email") as? String {
            
            let ususarioModel = UsuarioModel(nombre: nombre,
                                             apellidos: bbddObject.value(forKey: "apellidos") as? String,
                                             email: email,
                                             direccion: bbddObject.value(forKey: "direccion") as? String,
                                             pais: bbddObject.value(forKey: "pais") as? String,
                                             provincia: bbddObject.value(forKey: "provincia") as? String,
                                             ciudad: bbddObject.value(forKey: "ciudad") as? String,
                                             edad: bbddObject.value(forKey: "edad") as? Int,
                                             puntos: bbddObject.value(forKey: "puntos") as? Int,
                                             nivel: bbddObject.value(forKey: "nivel") as? Int,
                                             contrasena: contrasena,
                                             ultimoIngreso: bbddObject.value(forKey: "ultimoIngreso") as? String,
                                             version: nil,
                                             monedas: bbddObject.value(forKey: "monedas") as? Int,
                                             diamantes: bbddObject.value(forKey: "diamantes") as? Int,
                                             avatarActivo: bbddObject.value(forKey: "avatarActivo") as? String,
                                             avatares: nil,
                                             lugares: nil)
            return ususarioModel
        }
        return nil
    }
    
    static func deleteUsuario() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UsuarioEntity")
        //request.predicate = NSPredicate(format: "age = %@", "21")
        request.returnsObjectsAsFaults = false
        
        guard let bbddObject = try? context.fetch(request).first as? NSManagedObject else { return }
        
        context.delete(bbddObject)
    }
}
