//
//  CamerinosWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 11/10/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


protocol CamerinosWorkerProtocol{
    func failCamerino()
    func comprado()
    func activado()
}

class CamerinosWorker: BaseWorker{
    
    var delegate: CamerinosWorkerProtocol?
    
    
    func comprarAvatar(avatar: Avatar, delegate: CamerinosWorkerProtocol){
        self.delegate = delegate
        
        manager.request(
        getUrl(url: .comprarAvatar),
        method: .post,
        parameters:["nombre": Usuario.shared.nombre, "avatar": avatar.nombre ?? ""],
        headers: headers).responseJSON { response in
            if let data = response.data{
                do {
                    switch response.response?.statusCode ?? -1 {
                    case 200:
                        self.delegate?.comprado()
                    case 400,401,410,500:
                        self.delegate?.failCamerino()
                    default:
                        self.delegate?.failCamerino()
                    }
                }catch{
                    self.delegate?.failCamerino()
                }
            } else {
                self.delegate?.failCamerino()
            }
        }
    }
    
    func activarAvatar(avatar: Avatar, delegate: CamerinosWorkerProtocol){
        self.delegate = delegate
        
        manager.request(
        getUrl(url: .activarAvatar),
        method: .post,
        parameters:["nombre": Usuario.shared.nombre, "avatar": avatar.nombre ?? ""],
        headers: headers).responseJSON { response in
            if let data = response.data{
                do {
                    switch response.response?.statusCode ?? -1 {
                    case 200:
                        self.delegate?.activado()
                    case 400,401,410,500:
                        self.delegate?.failCamerino()
                    default:
                        self.delegate?.failCamerino()
                    }
                }catch{
                    self.delegate?.failCamerino()
                }
            } else {
                self.delegate?.failCamerino()
            }
        }
    }
    
    
    
}
