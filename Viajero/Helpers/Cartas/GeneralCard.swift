//
//  GeneralCard.swift
//  Viajero
//
//  Created by Mikel Lopez on 27/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class GeneralCard: UIView{

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet var view: UIView!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("GeneralCard", owner: self, options: nil)
        view.frame = bounds
        self.addSubview(self.view)
    }
    
    func configure(titulo: String, descripcion: String, imagen: UIImage){
        view.addShadowInContainerView()
        self.titulo.text = titulo
        self.descripcion.text = descripcion
        self.imagen.image = imagen
    }
    
    
    
}
