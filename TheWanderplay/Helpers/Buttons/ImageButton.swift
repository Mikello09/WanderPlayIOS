//
//  ImageButton.swift
//  TheWanderplay
//
//  Created by Mikel Lopez Salazar on 15/9/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class ImageButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 4
        layer.borderWidth = 2
        layer.borderColor = UIColor.principal.cgColor
        backgroundColor = .secondary
    }
}
