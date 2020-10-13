//
//  NoTrophyView.swift
//  Viajero
//
//  Created by Mikel Lopez on 26/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class NoTrophyView: UICollectionViewCell{
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var progreso: UIProgressView!
    @IBOutlet weak var monedasView: UIView!
    @IBOutlet weak var monedasLabel: UILabel!
    @IBOutlet weak var diamantesView: UIView!
    @IBOutlet weak var diamantesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(mensaje: String, porcentaje: Double, monedas: Int, diamantes: Int){
        container.addShadowInContainerView()
        titulo.text = mensaje
        progreso.setProgress(Float(porcentaje)/100, animated: true)
        progreso.addShadowInContainerView(withBorder: false)
        
        if monedas > 0{
            monedasView.isHidden = false
            monedasLabel.text = "\(monedas)"
        }
        if diamantes > 0{
            diamantesView.isHidden = false
            diamantesLabel.text = "\(diamantes)"
        }
    }
    
}
