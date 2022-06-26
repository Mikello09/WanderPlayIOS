//
//  LoginWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 28/08/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol LoginWorkerProtocol {
    func success()
    func fail(error: String)
}

class LoginWorker: BaseWorker {
    
    var delegate: LoginWorkerProtocol?
    
    func execute(nombre: String, pass: String, delegate: LoginWorkerProtocol) {
        self.delegate = delegate
        guard let loginURL = URL(string: getUrl(url: .login)) else {
            delegate.fail(error: "Bad url formation")
            return
        }
        
        let session = getUrlSession()
        let request = generateRequest(url: loginURL,
                                      method: .post,
                                      params: ["nombre":nombre,
                                               "contrasena":pass])
        let dataTask: URLSessionDataTask?
        dataTask = session.dataTask(with: request){ data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                do {
                    switch response.statusCode {
                    case 200:
                        let response = try self.newJSONDecoder().decode(UsuarioModelo.self, from: data)
                        Usuario.shared.guardarUsuario(usuario: response.usuario)
                        Usuario.shared.guardarCredenciales(nombre: response.usuario?.nombre ?? "", pass: response.usuario?.contrasena ?? "")
                        self.delegate?.success()
                    case 400,401,500:
                        let response = try self.newJSONDecoder().decode(Error.self, from: data)
                        self.delegate?.fail(error: response.reason)
                    default:
                        self.delegate?.fail(error: self.errorGeneral)
                    }
                }catch {
                    self.delegate?.fail(error: self.errorGeneral)
                }
            }
        }
        dataTask?.resume()
        
        
//       manager.request(
//            getUrl(url: .login),
//            method: .post,
//            parameters: ["nombre":nombre,"pass":pass],
//            headers: headers).responseJSON { response in
//
//                if let data = response.data{
//                    do {
//                        switch response.response?.statusCode ?? -1 {
//                        case 200:
//                            let response = try self.newJSONDecoder().decode(UsuarioModelo.self, from: data)
//                            Usuario.shared.guardarUsuario(usuario: response.usuario)
//                            Usuario.shared.guardarCredenciales(nombre: response.usuario?.nombre ?? "", pass: response.usuario?.contrasena ?? "")
//                            self.delegate?.success()
//                        case 400,401,500:
//                            let response = try self.newJSONDecoder().decode(Error.self, from: data)
//                            self.delegate?.fail(error: response.reason)
//                        default:
//                            self.delegate?.fail(error: self.errorGeneral)
//                        }
//                    }catch{
//                        self.delegate?.fail(error: self.errorGeneral)
//                    }
//                } else {
//                    self.delegate?.fail(error: self.errorGeneral)
//                }
//            }
    }
    
}
