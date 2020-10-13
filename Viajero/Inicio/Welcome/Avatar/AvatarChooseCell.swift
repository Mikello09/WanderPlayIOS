//
//  AvatarChooseCell.swift
//  Viajero
//
//  Created by Mikel Lopez on 02/05/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol AvatarChooseCellProtocol{
    func avatarChoosen(avatar: Avatar)
}

class AvatarChooseCell: UICollectionViewCell{
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var imagen: UIImageView!
    
    var seleccionado: Bool = false
    
    var delegate: AvatarChooseCellProtocol?
    var avatar: Avatar?
    
    func configure(delegate: AvatarChooseCellProtocol?, avatar: Avatar, seleccionado: Bool){
        self.delegate = delegate
        self.avatar = avatar
        self.seleccionado = seleccionado
        
        if seleccionado{
            container.removeShadow()
            container.layer.cornerRadius = 3
            container.layer.borderWidth = 5
            container.layer.borderColor = Colors.amarillo.cgColor
        } else {
            container.addShadowInContainerView()
        }
        
        imagen.image = UIImage(named: avatar.getImage())
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarChoosen))
        container.isUserInteractionEnabled = true
        container.addGestureRecognizer(tap)
    }
    
    @objc
    func avatarChoosen(){
        if let av = avatar, !seleccionado{
            self.delegate?.avatarChoosen(avatar: av)
        }
    }
}
