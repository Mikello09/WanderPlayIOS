//
//  LugarInfoView.swift
//  Viajero
//
//  Created by Mikel Lopez Salazar on 11/7/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol LugarInfoViewProtocol {
    func onGoToDetalles(idLugar: String)
}

class LugarInfoView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var lugarPinImage: UIImageView!
    @IBOutlet weak var lugarTitle: UILabel!
    @IBOutlet weak var lugarImageContainer: UIView!
    @IBOutlet weak var lugarImage: UIImageView!
    @IBOutlet weak var monedasButton: UIButton!
    @IBOutlet weak var verDetalleButton: UIButton!
    
    var delegate: LugarInfoViewProtocol?
    var idLugar: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("LugarInfoView", owner: self, options: nil)
        view.frame = bounds
        self.addSubview(self.view)
    }
    
    func configure(nombre: String,
                   puntos: String,
                   foto: String,
                   id: String,
                   tipoLugar: String,
                   visitado: String,
                   delegate: LugarInfoViewProtocol) {
        self.delegate = delegate
        self.idLugar = id
        // Container
        //container.layer.cornerRadius = 8
        container.addShadowInContainerView(withRadius: 8)
        // PIN
        switch tipoLugar {
        case "BAJO":
            lugarPinImage.image = UIImage(named: "pin_verde_image")
            lugarImageContainer.layer.borderColor = Colors.verde.cgColor
        case "MEDIO":
            lugarPinImage.image = UIImage(named: "pin_azul_image")
            lugarImageContainer.layer.borderColor = Colors.azul.cgColor
        case "ALTO":
            lugarPinImage.image = UIImage(named: "pin_amarillo_image")
            lugarImageContainer.layer.borderColor = Colors.amarillo.cgColor
        case "MUYALTO":
            lugarPinImage.image = UIImage(named: "pin_naranja_image")
            lugarImageContainer.layer.borderColor = Colors.naranja.cgColor
        case "PATRIMONIO":
            lugarPinImage.image = UIImage(named: "pin_rojo_image")
            lugarImageContainer.layer.borderColor = Colors.rojo.cgColor
        default: ()
        }
        // TITLE
        lugarTitle.text = nombre
        //IMAGE
        lugarImageContainer.layer.cornerRadius = 4
        lugarImageContainer.layer.borderWidth = 2
        lugarImage.layer.masksToBounds = true
        lugarImage.clipsToBounds = true
        lugarImage.layer.cornerRadius = 4
        Task.init {
            if let fotoURL = URL(string: foto),
               let imageData = try? await URLSession.shared.data(from: fotoURL) {
                   lugarImage.image = UIImage(data: imageData.0)
            } else {
                lugarImage.contentMode = .scaleAspectFit
                lugarImage.image = UIImage(systemName: "photo")
            }
        }
        
        // Buttons
        verDetalleButton.setTitle("Ver más", for: .normal)
        
    }
    
    @IBAction func onVerDetalles(_ sender: Any) {
        if let idLugar = idLugar {
            delegate?.onGoToDetalles(idLugar: idLugar)
        }
    }
    
}
