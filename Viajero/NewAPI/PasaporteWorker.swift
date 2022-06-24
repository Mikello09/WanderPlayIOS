//
//  PasaporteWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 12/09/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol PasaporteAllLogrosProtocol{
    func successAllLogros(groupedLogros: [GroupedLogros])
    func failAllLogros()
}

class PasaporteWorker: BaseWorker{
    
    
    var delegate: PasaporteAllLogrosProtocol?
    
    func getAllLogros(delegate: PasaporteAllLogrosProtocol){
        self.delegate = delegate
        
        guard let getAllLogrosURL = URL(string: getUrl(url: .getAllLogros)) else {
            delegate.failAllLogros()
            return
        }
        
        let session = getUrlSession()
        let request = generateRequest(url: getAllLogrosURL, method: .post)
        let dataTask: URLSessionDataTask?
        
        dataTask = session.dataTask(with: request){ data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                do {
                    switch response.statusCode ?? -1 {
                    case 200:
                        let response = try self.newJSONDecoder().decode([GroupedLogros].self, from: data)
                        self.delegate?.successAllLogros(groupedLogros: response)
                    case 400,401,500:
                        let response = try self.newJSONDecoder().decode(Error.self, from: data)
                        self.delegate?.failAllLogros()
                    default:
                        self.delegate?.failAllLogros()
                    }
                }catch{
                    self.delegate?.failAllLogros()
                }
            } else {
                self.delegate?.failAllLogros()
            }
        }
        dataTask?.resume()
        
        
        
//        manager.request(
//        getUrl(url: .getAllLogros),
//        method: .post,
//        parameters: ["nombre": Usuario.shared.nombre],
//        headers: headers).responseJSON { response in
//            if let data = response.data{
//                do {
//                    switch response.response?.statusCode ?? -1 {
//                    case 200:
//                        let response = try self.newJSONDecoder().decode([GroupedLogros].self, from: data)
//                        self.delegate?.successAllLogros(groupedLogros: response)
//                    case 400,401,500:
//                        let response = try self.newJSONDecoder().decode(Error.self, from: data)
//                        self.delegate?.failAllLogros()
//                    default:
//                        self.delegate?.failAllLogros()
//                    }
//                }catch{
//                    self.delegate?.failAllLogros()
//                }
//            } else {
//                self.delegate?.failAllLogros()
//            }
//        }
    }
    
}
