//
//  Colors.swift
//  Viajero
//
//  Created by Mikel Lopez on 17/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    
    static let azul = UIColor(red: 0/255.0, green: 160/255.0, blue: 225/255.0, alpha: 1.0)
    static let amarillo = UIColor(red: 254/255.0, green: 187/255.0, blue: 2/255.0, alpha: 1.0)
    static let gris = UIColor(red: 166/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1.0)
    static let verde = UIColor(red: 0/255.0, green: 204/255.0, blue: 102/255.0, alpha: 1.0)
    static let naranja = UIColor(red: 255/255.0, green: 153/255.0, blue: 51/255.0, alpha: 1.0)
    static let rojo = UIColor(red: 255/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
    
    static let azulTransparente = UIColor(red: 0/255.0, green: 160/255.0, blue: 225/255.0, alpha: 1.0)
    static let amarilloTransparente = UIColor(red: 254/255.0, green: 187/255.0, blue: 2/255.0, alpha: 0.5)
    static let grisTransparente = UIColor(red: 166/255.0, green: 166/255.0, blue: 166/255.0, alpha: 0.5)
    static let verdeTransparente = UIColor(red: 0/255.0, green: 204/255.0, blue: 102/255.0, alpha: 0.5)
    static let naranjaTransparente = UIColor(red: 255/255.0, green: 153/255.0, blue: 51/255.0, alpha: 0.5)
    static let rojoTransparente = UIColor(red: 255/255.0, green: 51/255.0, blue: 51/255.0, alpha: 0.5)
    
    static let principal = UIColor.init(named: "Principal")!
    static let secondary = UIColor.init(named: "Secondary")!
    static let text = UIColor.init(named: "Text")!
    static let elementBackground = UIColor.init(named: "ElementBakcground")!
    
}

extension UIColor {
    static let principal = Colors.principal
    static let secondary = Colors.secondary
    static let text = Colors.text
    static let elementBackground = Colors.elementBackground
}
