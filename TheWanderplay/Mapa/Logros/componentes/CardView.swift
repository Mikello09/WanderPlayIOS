//
//  CardView.swift
//  Viajero
//
//  Created by Mikel Lopez on 15/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


class CardView: UIView{
    @IBOutlet var view: UIView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var valorView: UIView!
    @IBOutlet weak var diamanteLabel: UILabel!
    @IBOutlet weak var monedaLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var contenedor: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        view.frame = bounds
        self.addSubview(self.view)
    }
    
    func configure(titulo: String, monedas: String, diamantes: String, imagen: String){
        self.contenedor.addShadowInContainerView()
        self.titulo.text = titulo
        self.monedaLabel.text = monedas
        self.diamanteLabel.text = diamantes
        self.imagen.image = UIImage(named: "trophy1")
        titleView.addShadowInContainerView()
    }
}
