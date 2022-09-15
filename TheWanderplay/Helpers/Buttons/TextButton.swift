//
//  TextButton.swift
//  TheWanderplay
//
//  Created by Mikel Lopez Salazar on 15/9/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class TextButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setTitleColor(.blue, for: .normal)
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
    }
    
}
