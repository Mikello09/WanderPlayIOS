//
//  AvisoStandar.swift
//  Viajero
//
//  Created by Mikel Lopez on 29/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


protocol AvisoStandardProtocol{
    func closeAviso()
}


class AvisoStandar: UIView{
    
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var mensaje: UILabel!
    @IBOutlet weak var botonAceptar: UIButton!
    @IBOutlet weak var botonCerrar: UIButton!
    
    var aceptarAction: (()-> Void)?
    
    var delegate: AvisoStandardProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("AvisoStandar", owner: self, options: nil)
        view.frame = bounds
        self.addSubview(self.view)
    }
    
    func configure(titulo: String, mensaje: String, aceptarAction: @escaping() -> (), delegate: AvisoStandardProtocol){
        self.delegate = delegate
        self.titulo.text = titulo
        self.mensaje.text = mensaje
        self.aceptarAction = aceptarAction
        self.botonAceptar.addShadowInContainerView(withRadius: 10)
        self.view.addShadowInContainerView()
    }
 
    @IBAction func cerrarClicked(_ sender: UIButton) {
        delegate?.closeAviso()
    }
    
    @IBAction func aceptarClicked(_ sender: UIButton) {
        aceptarAction!()
        delegate?.closeAviso()
    }
}
