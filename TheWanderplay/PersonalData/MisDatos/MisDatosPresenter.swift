//
//  MisDatosPresenter.swift
//  Viajero
//
//  Created by Mikel Lopez on 25/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


struct MisDatosModel {
    var posicion: Int
    var tipo: MisDatosFieldType
    var valor: String
}

protocol MisDatosProtocol{
    func paintCampos(campos: [MisDatosModel])
    func updateProgreso(progreso: Float)
}


class MisDatosPresenter{
    
    var misDatosAMostrar: [MisDatosModel] = []
    var delegate: MisDatosProtocol?
    
    var infoUpdated: Bool = false
    
    func getCamposAMostrar(){
        misDatosAMostrar.append(MisDatosModel(posicion: 0, tipo: .nombre, valor: ""))
        misDatosAMostrar.append(MisDatosModel(posicion: 1, tipo: .apellido, valor: ""))
        misDatosAMostrar.append(MisDatosModel(posicion: 2, tipo: .email, valor: ""))
        misDatosAMostrar.append(MisDatosModel(posicion: 3, tipo: .ciudad, valor: ""))
        misDatosAMostrar.append(MisDatosModel(posicion: 4, tipo: .direccion, valor: ""))
        misDatosAMostrar.append(MisDatosModel(posicion: 5, tipo: .pais, valor: ""))
        misDatosAMostrar.append(MisDatosModel(posicion: 6, tipo: .provincia, valor: ""))
        misDatosAMostrar.append(MisDatosModel(posicion: 7, tipo: .telefono, valor: ""))
        
        delegate?.paintCampos(campos: misDatosAMostrar)
        calculateProgreso()
    }
    
    func updateFieldValue(posicion: Int, valor: String){
        misDatosAMostrar[posicion].valor = valor
        calculateProgreso()
        infoUpdated = true
    }
    
    func calculateProgreso(){
        var progreso: Float = 0
        for campo in misDatosAMostrar{
            if campo.valor != ""{
                progreso += 1
            }
        }
        delegate?.updateProgreso(progreso: (progreso/Float(misDatosAMostrar.count)))
    }
    
}
