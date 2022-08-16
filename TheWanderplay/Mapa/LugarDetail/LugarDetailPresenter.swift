//
//  LugarDetailPresenter.swift
//  Viajero
//
//  Created by Mikel Lopez on 26/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol LugarDetailProtocol{
    func lugarObtained(lugar: Lugar)
    func errorInGettingLugar()
}

class LugarDetailPresenter{
    
    var idLugar: String = ""
    var delegate: LugarDetailProtocol?
    
    func getLugar(){
        if let lugar = LugaresManager.shared.getLugarFromId(lugarId: self.idLugar){
            delegate?.lugarObtained(lugar: lugar)
        } else {
            delegate?.errorInGettingLugar()
        }
    }
    
    func createImages(lugar: Lugar) -> [CustomScrollView]{
        
        var imageCarrusel: [CustomScrollView] = []
        
        if lugar.foto1 != ""{
            if let url = URL(string: lugar.foto1 ?? ""){
                let fotoImage1: CustomScrollView = CustomScrollView()
                let resource = ImageResource(downloadURL: url)
                fotoImage1.image.kf.setImage(with: resource)
                imageCarrusel.append(fotoImage1)
            }
        }
        
        if lugar.foto2 != ""{
           if let url = URL(string: lugar.foto2 ?? ""){
               let fotoImage2: CustomScrollView = CustomScrollView()
               let resource = ImageResource(downloadURL: url)
               fotoImage2.image.kf.setImage(with: resource)
               imageCarrusel.append(fotoImage2)
           }
        }
        
        if lugar.foto3 != ""{
           if let url = URL(string: lugar.foto3 ?? ""){
               let fotoImage3: CustomScrollView = CustomScrollView()
               let resource = ImageResource(downloadURL: url)
               fotoImage3.image.kf.setImage(with: resource)
               imageCarrusel.append(fotoImage3)
           }
        }
        
        return imageCarrusel
    }
    
}
