//
//  LogroWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 17/09/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol LogroWorkerProtocol{
    func logroSuccess(logros: [Logro], lugar: String)
    func logroFail()
}

class LogroWorker: BaseWorker{
    
    var delegate: LogroWorkerProtocol?
    
    func askForLogros(lugar: String, delegate: LogroWorkerProtocol){
        self.delegate = delegate
        
        manager.request(
        getUrl(url: .askForLogros),
        method: .post,
        parameters: ["nombre": Usuario.shared.nombre, "lugar": lugar],
        headers: headers).responseJSON { response in
            if let data = response.data{
                do {
                    switch response.response?.statusCode ?? -1 {
                    case 200:
                        let response = try self.newJSONDecoder().decode(RespuestaLogros.self, from: data)
                        self.delegate?.logroSuccess(logros: response.logros ?? [], lugar: lugar)
                    case 400,401,410,500:
                        let response = try self.newJSONDecoder().decode(Error.self, from: data)
                        self.delegate?.logroFail()
                    default:
                        self.delegate?.logroFail()
                    }
                }catch{
                    self.delegate?.logroFail()
                }
            } else {
                self.delegate?.logroFail()
            }
        }
    }
    
}
