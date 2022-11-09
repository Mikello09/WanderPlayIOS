//
//  SettingsBBDD.swift
//  TheWanderplay
//
//  Created by Mikel Lopez Salazar on 9/11/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class SettingsBBDD {
    
    static func saveLugaresCreatedDate(createdDate: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SettingsEntity", in: context) else { return }
        let newUser = NSManagedObject(entity: entity, insertInto: context)
        
        newUser.setValue(createdDate, forKey: "lugaresCreatedDate")
        
        do {
            try context.save()
         } catch {
          print("Error saving settings: \(error)")
        }
    }
    
    static func getLugaresCreatedDate() -> String? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SettingsEntity")
        request.returnsObjectsAsFaults = false
        
        guard let bbddObject = try? context.fetch(request).first as? NSManagedObject else { return nil }
        
        return bbddObject.value(forKey: "lugaresCreatedDate") as? String
    }
    
}
