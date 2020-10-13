//
//  FiltrosCollectionCell.swift
//  Viajero
//
//  Created by Mikel Lopez on 30/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


struct FiltroCategoriaModel{
    var titulo: String
    var imagen: String
    var seleccionado: Bool
    var posicion: Int
}

struct FiltroPuntosModel{
    var valor: Int
}

protocol FiltrosCategoriaCellProtocol{
    func filtroSelected(posicion: Int)
    func filtroDeselected(posicion: Int)
}

class FiltrosCollectionCell: UICollectionViewCell{
    
  
    @IBOutlet var contenedor: UIView!
    @IBOutlet var imagen: UIImageView!
    @IBOutlet var titulo: UILabel!
    
    var filtroCategoria: FiltroCategoriaModel?
    var delegate: FiltrosCategoriaCellProtocol?
    
    func configure(filtro: FiltroCategoriaModel, delegate: FiltrosCategoriaCellProtocol){
        self.delegate = delegate
        self.filtroCategoria = filtro
        
        let tapView = UITapGestureRecognizer(target: self, action: #selector(filtroClicked))
        self.contenedor.isUserInteractionEnabled = true
        self.contenedor.addGestureRecognizer(tapView)
        
        
        self.titulo.text = filtro.titulo
        self.imagen.image = UIImage(named: self.filtroCategoria?.imagen ?? "")
        
        self.contenedor.addShadowInContainerView(withRadius: 25)
        
        if filtro.seleccionado {
            self.contenedor.backgroundColor = Colors.amarillo
        } else {
            self.contenedor.backgroundColor = Colors.gris
        }
        
    }
    
    @objc func filtroClicked(){
        if let filtroSelected = filtroCategoria{
            if filtroSelected.seleccionado{
                delegate?.filtroDeselected(posicion: filtroSelected.posicion)
            } else {
                delegate?.filtroSelected(posicion: filtroSelected.posicion)
            }
        }
    }
    
}
