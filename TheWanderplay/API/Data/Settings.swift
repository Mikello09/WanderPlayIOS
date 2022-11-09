//
//  Settings.swift
//  TheWanderplay
//
//  Created by Mikel Lopez Salazar on 9/11/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation


struct SettingsModel: Codable {
    var lugaresCreateDate: String
}

class Settings {
    
    static var shared: Settings = Settings()
    
    var lugaresCreateDate: String?
    
    func guardarLugaresCreateDate(createDate: String) {
        self.lugaresCreateDate = createDate
        SettingsBBDD.saveLugaresCreatedDate(createdDate: createDate)
    }
    
    func cargarSettings() {
        lugaresCreateDate = SettingsBBDD.getLugaresCreatedDate()
    }
    
}
