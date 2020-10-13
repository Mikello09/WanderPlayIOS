//
//  TrophyView.swift
//  Viajero
//
//  Created by Mikel Lopez on 26/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class TrophyView: UICollectionViewCell{
    
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var container: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(){
        imagen.contentMode = .scaleAspectFit
        container.addShadowInContainerView()
    }
    
}
