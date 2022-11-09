//
//  RegistroWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 08/09/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol RegistroWorkerProtocol{
    func success()
    func fail(error: String)
}

class RegistroWorker: BaseWorker{
    
    
    var delegate: RegistroWorkerProtocol?
    
    
    func registrarse(nombre: String, pass: String, avatar: String, delegate: RegistroWorkerProtocol){
        self.delegate = delegate
        
        guard let registroURL = URL(string: getUrl(url: .registro)) else {
            delegate.fail(error: "Bad url formation")
            return
        }
        
        var params: [String: Any] = [:]
        params["nombre"] = nombre
        params["avatar"] = pass
        params["pass"] = avatar
        
        let session = getUrlSession()
        let request = generateRequest(url: registroURL, method: .post, params: params)
        let dataTask: URLSessionDataTask?
        
        dataTask = session.dataTask(with: request){ data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                do {
                    switch response.statusCode ?? -1 {
                    case 200:
                        let response = try newJSONDecoder().decode(LoginModel.self, from: data)
                        Usuario.shared.guardarUsuario(usuario: response.usuario)
                        self.delegate?.success()
                    case 400,401,500:
                        let response = try newJSONDecoder().decode(Error.self, from: data)
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
        dataTask?.resume()
    }
    
}
