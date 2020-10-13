//
//  PersonalDataCollectionCell.swift
//  Viajero
//
//  Created by Mikel Lopez on 25/01/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


enum PersonalDataCollectionItem {
    case pasaporte
    case galeria
    case ranking
    case miPerfil
    case cerrarSesion
    case tomarFoto
    case ajustes
    case tienda
    
    func getTitle() -> String{
        switch self {
        case .pasaporte:
            return "Pasaporte"
        case .galeria:
            return "Galería"
        case .miPerfil:
            return "Mi Perfil"
        case .cerrarSesion:
            return "Cerrar Sesión"
        case .tomarFoto:
            return "Tomar Foto"
        case .ranking:
            return "Rankings"
        case .ajustes:
            return "Ajustes"
        case .tienda:
            return "Tienda"
        }
    }
    
    func getImage() -> UIImage?{
        switch self {
        case .pasaporte:
            return UIImage(systemName: "creditcard.fill")
        case .galeria:
            return UIImage(systemName: "photo.fill.on.rectangle.fill")
        case .miPerfil:
            return UIImage(systemName: "person.circle.fill")
        case .cerrarSesion:
            return UIImage(systemName: "power")
        case .tomarFoto:
            return UIImage(systemName: "camera.fill")
        case .ranking:
            return UIImage(systemName: "list.number")
        case .ajustes:
            return UIImage(systemName: "gear")
        case .tienda:
            return UIImage(systemName: "cart.fill")
        }
    }
}

class PersonalDataCollectionCell: UICollectionViewCell{
    
    @IBOutlet var imagen: UIImageView!
    @IBOutlet var titulo: UILabel!
    @IBOutlet weak var contenedor: UIView!
    @IBOutlet weak var proximamenteView: UIView!
    
    var item: PersonalDataCollectionItem?
    var from: UIViewController = UIViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(item: PersonalDataCollectionItem, from: UIViewController, dayMoment: DayMoment){
        self.item = item
        self.from = from
        imagen.image = item.getImage()
        imagen.tintColor = Colors.amarillo
        titulo.text = item.getTitle()
        titulo.textColor = UIColor.black
        contenedor.layer.cornerRadius = 10
        contenedor.addShadowInContainerView(withRadius: 10)
        switch item {
            case .galeria:
                self.proximamenteView.isHidden = false
            case .tienda:
                self.proximamenteView.isHidden = false
            case .miPerfil:
                self.proximamenteView.isHidden = false
            case .ajustes:
                self.proximamenteView.isHidden = false
            default:
                self.proximamenteView.isHidden = true
        }
        
    }
    
    @IBAction func onCellClicked(_ sender: UIButton) {
        if let item = self.item{
            switch item{
                case .cerrarSesion:
                    PersonalDataRouter().goToCerrarSesion(fromVC: from)
                    return
                case .galeria:
                    return
                case .miPerfil:
                    return
                case .ranking:
                    RankingRouter().goToRanking(navigationController: from.navigationController)
                case .tomarFoto:
                    TomarFotoRouter().goToTomarFoto(navigationController: from.navigationController)
                case .pasaporte:
                    PasaporteRouter().goToPasaporte(navigationController: from.navigationController)
                case .ajustes:
                    return
                case .tienda:
                    return
            }
        }
    }
}
