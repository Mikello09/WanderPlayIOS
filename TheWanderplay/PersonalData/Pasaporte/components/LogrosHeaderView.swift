//
//  LogrosView.swift
//  Viajero
//
//  Created by Mikel Lopez on 10/12/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class LogrosHeaderView: UICollectionReusableView{
    
 
    @IBOutlet var contadorLabel: UILabel!
    @IBOutlet var titulo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(titulo: String, contador: String){
        self.titulo.text = titulo
        self.contadorLabel.text = contador
    }
    
}
