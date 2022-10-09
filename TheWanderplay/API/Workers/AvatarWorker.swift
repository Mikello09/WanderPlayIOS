//
//  AvatarWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 08/09/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol GetAllAvataresProtocol{
    func success(avatares: [Avatar])
    func fail()
}

class AvatarWorker: BaseWorker{
    
        
    var delegate: GetAllAvataresProtocol?
    
    
    func getAllAvatares(delegate: GetAllAvataresProtocol){
        self.delegate = delegate
        
        guard let getAllAvataresURL = URL(string: getUrl(url: .getAllAvatares)) else {
            delegate.fail()
            return
        }
        
        let session = getUrlSession()
        let request = generateRequest(url: getAllAvataresURL, method: .post)
        let dataTask: URLSessionDataTask?
        
        dataTask = session.dataTask(with: request){ data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                do {
                    switch response.statusCode ?? -1 {
                    case 200:
                        let response = try newJSONDecoder().decode(AvatarModelo.self, from: data)
                        self.delegate?.success(avatares: response.avatares ?? [])
                    case 400,401,500:
                        let response = try newJSONDecoder().decode(Error.self, from: data)
                        self.delegate?.fail()
                    default:
                        self.delegate?.fail()
                    }
                }catch{
                    self.delegate?.fail()
                }
            } else {
                self.delegate?.fail()
            }
        }
        dataTask?.resume()
        
//        manager.request(
//        getUrl(url: .getAllAvatares),
//        method: .post,
//        headers: headers).responseJSON { response in
//
//            if let data = response.data{
//                do {
//                    switch response.response?.statusCode ?? -1 {
//                    case 200:
//                        let response = try self.newJSONDecoder().decode(AvatarModelo.self, from: data)
//                        self.delegate?.success(avatares: response.avatares ?? [])
//                    case 400,401,500:
//                        let response = try self.newJSONDecoder().decode(Error.self, from: data)
//                        self.delegate?.fail()
//                    default:
//                        self.delegate?.fail()
//                    }
//                }catch{
//                    self.delegate?.fail()
//                }
//            } else {
//                self.delegate?.fail()
//            }
//        }
    }
    
}
