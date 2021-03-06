//
//  RegistroWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 08/09/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


protocol RegistroWorkerProtocol{
    func success()
    func fail(error: String)
}

class RegistroWorker: BaseWorker{
    
    
    var delegate: RegistroWorkerProtocol?
    
    
    func registrarse(nombre: String, pass: String, avatar: String, delegate: RegistroWorkerProtocol){
        self.delegate = delegate
        manager.request(
        getUrl(url: .registro),
        method: .post,
        parameters: ["nombre":nombre,"pass":pass, "avatar": avatar],
        headers: headers).responseJSON { response in
            if let data = response.data{
                do {
                    switch response.response?.statusCode ?? -1 {
                    case 200:
                        let response = try self.newJSONDecoder().decode(UsuarioModelo.self, from: data)
                        Usuario.shared.guardarCredenciales(nombre: response.usuario?.nombre ?? "", pass: response.usuario?.contrasena ?? "")
                        self.delegate?.success()
                    case 400,401,500:
                        let response = try self.newJSONDecoder().decode(Error.self, from: data)
                        self.delegate?.fail(error: response.reason)
                    default:
                        self.delegate?.fail(error: self.errorGeneral)
                    }
                }catch{
                    self.delegate?.fail(error: self.errorGeneral)
                }
            } else {
                self.delegate?.fail(error: self.errorGeneral)
            }
        }
    }
    
}
