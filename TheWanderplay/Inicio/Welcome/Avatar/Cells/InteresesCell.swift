//
//  InteresesCell.swift
//  Viajero
//
//  Created by Mikel Lopez on 04/05/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class InteresesCell: UICollectionViewCell{
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var container: UIView!
    
    
    func configure(tipoInteres: Categoria){
        container.backgroundColor = UIColor.white
        container.addShadowInContainerView(withRadius: 20)
        self.imagen.image = UIImage(named: tipoInteres.rawValue)
    }
    
}
