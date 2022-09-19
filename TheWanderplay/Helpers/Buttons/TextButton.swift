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
        layer.cornerRadius = 4
        setTitleColor(.principal, for: .normal)
        setTitleColor(.principal, for: .highlighted)
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        backgroundColor = .secondary
        self.addShadowInContainerView()
    }
    
}
