//
//  RightBarMenu.swift
//  Viajero
//
//  Created by Mikel Lopez on 10/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import Lottie


protocol FiltrosInteresViewProtocol{
    func updateInteresLugares(interesFiltros: [Interes])
}

class FiltrosInteresView: UIView{
    @IBOutlet var view: UIView!
    @IBOutlet weak var container: UIView!
    
    @IBOutlet var rojoImage: UIImageView!
    @IBOutlet var naranjaImage: UIImageView!
    @IBOutlet var amarilloImage: UIImageView!
    @IBOutlet var azulImage: UIImageView!
    @IBOutlet var verdeImage: UIImageView!
    
    @IBOutlet var containerRojo: UIView!
    @IBOutlet var containerNaranja: UIView!
    @IBOutlet var containerAmarillo: UIView!
    @IBOutlet var containerAzul: UIView!
    @IBOutlet var containerVerde: UIView!
    
    var delegate: FiltrosInteresViewProtocol?
    
    var filtrosPin: [Interes] = [.bajo, .medio, .alto, .muyAlto, .patrimonio]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("FiltrosInteresView", owner: self, options: nil)
        view.frame = bounds
        self.addSubview(self.view)
    }
    
    func configure(delegate: FiltrosInteresViewProtocol){
        self.delegate = delegate
        
        container.addShadowInContainerView(withRadius: 8)
        containerRojo.addShadowInContainerView()
        containerNaranja.addShadowInContainerView()
        containerAmarillo.addShadowInContainerView()
        containerAzul.addShadowInContainerView()
        containerVerde.addShadowInContainerView()
        
        containerRojo.removeShadow()
        containerNaranja.removeShadow()
        containerAmarillo.removeShadow()
        containerAzul.removeShadow()
        containerVerde.removeShadow()
        
    }
    @IBAction func rojoPinClicked(_ sender: UIButton) {
        updateFiltrosPin(tipo: .patrimonio, image: rojoImage, contenedor: containerRojo)
    }
    
    @IBAction func naranjaPinClicked(_ sender: UIButton) {
        updateFiltrosPin(tipo: .muyAlto, image: naranjaImage, contenedor: containerNaranja)
    }
    
    @IBAction func amarilloPinClicked(_ sender: UIButton) {
        updateFiltrosPin(tipo: .alto, image: amarilloImage, contenedor: containerAmarillo)
    }
    
    @IBAction func azulPinClicked(_ sender: UIButton) {
        updateFiltrosPin(tipo: .medio, image: azulImage, contenedor: containerAzul)
    }
    
    @IBAction func verdePinClicked(_ sender: UIButton) {
        updateFiltrosPin(tipo: .bajo, image: verdeImage, contenedor: containerVerde)
    }
    
    func updateFiltrosPin(tipo: Interes, image: UIImageView, contenedor: UIView) {
        if filtrosPin.contains(tipo) {
            if filtrosPin.count != 1 {//para que siempre haya como minimo un pin con color
                var nuevosFiltros: [Interes] = []
                for filtro in filtrosPin where filtro != tipo {
                    nuevosFiltros.append(filtro)
                }
                filtrosPin = nuevosFiltros
                image.image = UIImage(named: "pin_gris_image")
                contenedor.addShadowInContainerView()
            }
        } else {
            filtrosPin.append(tipo)
            image.image = UIImage(named: tipo.getImage())
            contenedor.removeShadow()
        }
        delegate?.updateInteresLugares(interesFiltros: filtrosPin)
    }
}
