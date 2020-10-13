//
//  BaseWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 28/08/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class BaseWorker{
    
    
    var baseUrl = "https://wanderplay.herokuapp.com/"
    var headers = ["authToken":"AAAAA"]
    let manager = Alamofire.SessionManager.default
    let errorGeneral = "Ha ocurrido un error. Vuelva a intentarlo."
    
    
    func newJSONDecoder() -> JSONDecoder{
        let decoder = JSONDecoder()
        if #available(iOS 10, OSX 10.12, tvOS 10.0, watchOS 3.0, *){
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
    
    enum Urls: String {
        case login = "usuarios/doLogin"
        case registro = "usuarios/registrarUsuario"
        case lugares = "lugares/getAllLugares"
        case getAllAvatares = "avatares/getAllAvatares"
        case getAllLogros = "logros/getAllLogros"
        case askForLogros = "logros/askForLogros"
        case getGeneralRankgin = "ranking/getGeneralRanking"
        case comprarAvatar = "usuarios/comprarAvatar"
        case activarAvatar = "usuarios/activarAvatar"
    }
    
    func getUrl(url: Urls) -> String{
        return "\(self.baseUrl)\(url.rawValue)"
    }
}


struct Error: Codable{
    var reason: String
}
