//
//  CategoriaCell.swift
//  TheWanderplay
//
//  Created by Mikel Lopez Salazar on 5/9/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol CategoriaCellProtocol {
    func categoriaSelected(categoria: Categoria)
}

class CategoriaCell: UITableViewCell {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var categoriaImage: UIImageView!
    
    var delegate: CategoriaCellProtocol?
    var categoria: Categoria?
    
    func configure(categoria: Categoria, isAcvite: Bool, delegate: CategoriaCellProtocol) {
        self.delegate = delegate
        self.categoria = categoria
        // Container
        isAcvite ? container.removeShadow() : container.addShadowInContainerView()
        container.alpha = isAcvite ? 1 : 0.5
        container.layer.cornerRadius = 4
        let tap = UITapGestureRecognizer(target: self, action: #selector(onCellSelected))
        container.addGestureRecognizer(tap)
        
        // Image
        categoriaImage.image = categoria.getImagen()
    }
    
    @objc
    func onCellSelected() {
        guard let categoria = categoria else { return }
        delegate?.categoriaSelected(categoria: categoria)
    }
}
