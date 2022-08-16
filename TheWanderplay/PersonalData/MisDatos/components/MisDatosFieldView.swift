//
//  MisDatosFieldView.swift
//  Viajero
//
//  Created by Mikel Lopez on 09/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

enum MisDatosFieldType: String {
    case nombre = "Nombre"
    case apellido = "Apellido"
    case email = "Email"
    case pass = "Contraseña"
    case telefono = "Teléfono"
    case direccion = "Dirección"
    case provincia = "Provincia"
    case ciudad = "Ciudad"
    case pais = "País"
}

protocol MisDatosFieldProtocol{
    func fieldEdited(posicion: Int, valor: String)
    func fieldSelected(posicion: Int)
}

class MisDatosFieldView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var stateImage: UIImageView!
    
    var tipo: MisDatosFieldType!
    var posicion: Int = 0
    var delegate: MisDatosFieldProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("MisDatosFieldView", owner: self, options: nil)
        view.frame = bounds
        self.addSubview(self.view)
    }
    
    func configure(posicion: Int, tipo: MisDatosFieldType, texto: String, delegate: MisDatosFieldProtocol){
        self.delegate = delegate
        self.tipo = tipo
        self.posicion = posicion
        self.title.text = tipo.rawValue
        self.field.placeholder = tipo.rawValue
        self.field.text = texto
        
        switch tipo {
            case .nombre:
                self.field.keyboardType = .default
            case .apellido:
                self.field.keyboardType = .default
            case .email:
                self.field.keyboardType = .emailAddress
            case .pass:
                self.field.keyboardType = .default
            case .telefono:
                self.field.keyboardType = .numberPad
            case .direccion:
                self.field.keyboardType = .default
            case .ciudad:
                self.field.keyboardType = .default
            case .provincia:
                self.field.keyboardType = .default
            case .pais:
                self.field.keyboardType = .default
        }
        field.delegate = self
        if texto == ""{
            setEmptyField()
        } else {
            setFilledField()
        }
    }
    
    func setEmptyField(){
        stateImage.image = UIImage(named: "red-face")
    }
    
    func setFilledField(){
        stateImage.image = UIImage(named: "green-face-big")
    }
    
}

extension MisDatosFieldView: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text ?? "" == ""{
            setEmptyField()
        } else {
            setFilledField()
        }
        delegate?.fieldEdited(posicion: self.posicion, valor: textField.text ?? "")
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.fieldSelected(posicion: self.posicion)
        return true
    }
    
}
