//
//  LugarWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 30/08/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


protocol LugarWorkerProtocol{
    func successLugares()
    func failLugares(error: String)
}

class LugarWorker: BaseWorker{
    
    var delegate: LugarWorkerProtocol?
    
    func execute(delegate: LugarWorkerProtocol){
        self.delegate = delegate
        
        guard let lugaresURL = URL(string: getUrl(url: .lugares)) else {
            delegate.failLugares(error: "Bad url formation")
            return
        }
        
        let session = getUrlSession()
        let request = generateRequest(url: lugaresURL, method: .post)
        let dataTask: URLSessionDataTask?
        
        dataTask = session.dataTask(with: request){ data, response, error in
            if let data = data, let response = response as? HTTPURLResponse{
                do {
                    switch response.statusCode ?? -1 {
                    case 200:
                        let response = try self.newJSONDecoder().decode(LugarModelo.self, from: data)
                        Lugares.shared.guardarLugares(lugares: response.lugares ?? [])
                        self.delegate?.successLugares()
                    case 400,401,500:
                        let response = try self.newJSONDecoder().decode(Error.self, from: data)
                        self.delegate?.failLugares(error: response.reason)
                    default:
                        self.delegate?.failLugares(error: self.errorGeneral)
                    }
                }catch{
                    self.delegate?.failLugares(error: self.errorGeneral)
                }
            } else {
                self.delegate?.failLugares(error: self.errorGeneral)
            }
        }
        dataTask?.resume()
    }
    
}
