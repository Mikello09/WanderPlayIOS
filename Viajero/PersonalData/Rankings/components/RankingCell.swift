//
//  RankingCell.swift
//  Viajero
//
//  Created by Mikel Lopez on 28/01/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


class RankingCell: UITableViewCell{
    
    @IBOutlet var container: UIView!
    @IBOutlet var posicion: UILabel!
    @IBOutlet var imagen: UIImageView!
    @IBOutlet var nombre: UILabel!
    @IBOutlet weak var nivel: UILabel!
    @IBOutlet weak var lugares: UILabel!
    
    
    func configure(posicion: Int,
                   imagen: String,
                   nombre: String,
                   lugares: [String],
                   nivel: String,
                   avatar: String){
        container.addShadowInContainerView(withRadius: 5)
        self.posicion.text = "\(posicion)º"
        
        switch avatar {
        case "Playero":
            self.imagen.image = UIImage(named: "playero")
        case "Inspector":
            self.imagen.image = UIImage(named: "Inspector")
        case "Militar":
            self.imagen.image = UIImage(named: "militar")
        default:
            self.imagen.image = UIImage(named: "avatar_icon")
        }
        
        self.imagen.layer.cornerRadius = 30
        self.imagen.layer.borderWidth = 2
        self.imagen.layer.borderColor = Colors.amarillo.cgColor
        self.imagen.backgroundColor = UIColor.black
        self.nombre.text = nombre
        self.lugares.text = "\(lugares.count)"
        self.nivel.text = "Nvl \(nivel)"
        if nombre == Usuario.shared.nombre{
            container.backgroundColor = Colors.amarillo.withAlphaComponent(0.5)
        } else {
            container.backgroundColor = UIColor.white
        }
    }
    
    
    
}
