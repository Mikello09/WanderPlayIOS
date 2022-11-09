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
                        let response = try newJSONDecoder().decode(LoginModel.self, from: data)
                        DispatchQueue.main.async {
                            Usuario.shared.guardarUsuario(usuario: response.usuario)
                            Settings.shared.guardarLugaresCreateDate(createDate: response.settings.lugaresCreateDate)
                            self.delegate?.success()
                        }
                    case 400,401,500:
                        let response = try newJSONDecoder().decode(Error.self, from: data)
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
    }
}
