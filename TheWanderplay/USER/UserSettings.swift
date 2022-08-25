//
//  UserSettings.swift
//  TheWanderplay
//
//  Created by Mikel Lopez Salazar on 25/8/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class UserSettings {
    
    static func setZoomLevel(zoomLevel: CGFloat) {
        UserDefaults.standard.set(zoomLevel, forKey: "ZOOM_LEVEL")
    }
    
    static func getZoomLevel() -> CGFloat {
        return UserDefaults.standard.value(forKey: "ZOOM_LEVEL") as? CGFloat ?? 18
    }
    
}
