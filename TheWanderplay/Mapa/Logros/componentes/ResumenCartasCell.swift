//
//  ResumenCartasCell.swift
//  Viajero
//
//  Created by Mikel Lopez on 19/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class ResumenCartasCell: UICollectionViewCell{
    
    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(titulo: String, monedas: String, diamantes: String, imagen: String){
        cardView.configure(titulo: titulo, monedas: monedas, diamantes: diamantes, imagen: imagen)
    }
    
}
