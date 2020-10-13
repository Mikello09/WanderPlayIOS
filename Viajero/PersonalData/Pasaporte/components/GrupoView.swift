//
//  GrupoView.swift
//  Viajero
//
//  Created by Mikel Lopez on 24/04/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol GrupoViewProtocol{
    func grupoSelected(grupo: String)
}

class GrupoView: UICollectionViewCell{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var flechaView: UIView!
    
    var delegate: GrupoViewProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(titulo: String, showTriangle: Bool, delegate: GrupoViewProtocol){
        self.delegate = delegate
        self.titulo.text = titulo
        switch titulo {
            case "Lugares":
                self.imagen.image = UIImage(named: showTriangle ? "pin_amarillo_image" : "pin_gris_image")
            case "General":
                self.imagen.image = UIImage(systemName: "gear")
            case "Categorias":
                self.imagen.image = UIImage(systemName: "list.bullet")
            case "CCAA":
                self.imagen.image = UIImage(named: showTriangle ? "country_amarillo" : "country_gris")
            case "Nivel":
                self.imagen.image = UIImage(named: showTriangle ? "podium_amarillo" : "podium_gris")
            default:
                self.imagen.image = UIImage(named: "red-face")
        }
        if showTriangle {
            self.imagen.tintColor = Colors.amarillo
            setDownTriangle()
            containerView.removeShadow()
            containerView.layer.borderWidth = 0
            containerView.layer.cornerRadius = 3
        } else {
            self.imagen.tintColor = Colors.gris
            containerView.addShadowInContainerView()
            flechaView.layer.sublayers?.forEach{$0.removeFromSuperlayer()}
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(grupoTapped))
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(tap)
    }
    
    func setDownTriangle(){
        let heightWidth = flechaView.frame.size.width
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:0))
        path.addLine(to: CGPoint(x:0, y:0))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.white.cgColor

        flechaView.layer.insertSublayer(shape, at: 0)
    }
    
    @objc
    func grupoTapped(){
        self.delegate?.grupoSelected(grupo: self.titulo.text ?? "")
    }
}
