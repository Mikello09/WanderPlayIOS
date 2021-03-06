//
//  RankingWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 19/09/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import Alamofire



protocol RankingProtocol {
    func generalRanking(usuarios: [UsuarioModel])
    func failGeneralRanking()
}

class RankingWorker: BaseWorker{
    
    var delegate: RankingProtocol?
    
    
    func getGeneralRanking(delegate: RankingProtocol){
        self.delegate = delegate
        
        
        manager.request(
        getUrl(url: .getGeneralRankgin),
        method: .post,
        headers: headers).responseJSON { response in
            if let data = response.data{
                do {
                    switch response.response?.statusCode ?? -1 {
                    case 200:
                        let response = try self.newJSONDecoder().decode(Ranking.self, from: data)
                        self.delegate?.generalRanking(usuarios: response.usuarios)
                    case 400,401,410,500:
                        let response = try self.newJSONDecoder().decode(Error.self, from: data)
                        self.delegate?.failGeneralRanking()
                    default:
                        self.delegate?.failGeneralRanking()
                    }
                }catch{
                    self.delegate?.failGeneralRanking()
                }
            } else {
                self.delegate?.failGeneralRanking()
            }
        }
        
        
    }
    
}
