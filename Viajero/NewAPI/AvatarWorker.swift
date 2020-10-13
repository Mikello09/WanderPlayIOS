//
//  AvatarWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 08/09/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


protocol GetAllAvataresProtocol{
    func success(avatares: [Avatar])
    func fail()
}

class AvatarWorker: BaseWorker{
    
    
    var delegate: GetAllAvataresProtocol?
    
    
    func getAllAvatares(delegate: GetAllAvataresProtocol){
        self.delegate = delegate
        
        manager.request(
        getUrl(url: .getAllAvatares),
        method: .post,
        headers: headers).responseJSON { response in
            
            if let data = response.data{
                do {
                    switch response.response?.statusCode ?? -1 {
                    case 200:
                        let response = try self.newJSONDecoder().decode(AvatarModelo.self, from: data)
                        self.delegate?.success(avatares: response.avatares ?? [])
                    case 400,401,500:
                        let response = try self.newJSONDecoder().decode(Error.self, from: data)
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
    }
    
}
