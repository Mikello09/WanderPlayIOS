//
//  ChooseAvatarPresenter.swift
//  Viajero
//
//  Created by Mikel Lopez on 01/05/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


protocol ChooseAvatarPresenterProtocol{
    func getAvatares(avatares: [Avatar])
}

class ChooseAvatarPresenter{
    
    var delegate: ChooseAvatarPresenterProtocol?
    
    func getAvatares(){
        AvatarWorker().getAllAvatares(delegate: self)
    }
    
}


extension ChooseAvatarPresenter: GetAllAvataresProtocol{
    func success(avatares: [Avatar]) {
        delegate?.getAvatares(avatares: avatares)
    }
    
    func fail() {
        delegate?.getAvatares(avatares: [])
    }
    
    
}
