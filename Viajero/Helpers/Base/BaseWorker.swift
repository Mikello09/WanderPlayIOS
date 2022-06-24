//
//  BaseWorker.swift
//  Viajero
//
//  Created by Mikel Lopez on 28/08/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

class BaseWorker{
    
    var baseUrl = "https://wanderplay.herokuapp.com/"
    var headers = ["authToken":"AAAAA"]
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
    
    func getUrlSession() -> URLSession {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 600
        sessionConfig.timeoutIntervalForResource = 600
        return URLSession(configuration: sessionConfig)
    }
    
    func generateRequest(url: URL, method: HttpMethod, params: [String: Any] = [:]) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if method == .post {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                print("Error generating body")
            }
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        return urlRequest
    }
}


struct Error: Codable{
    var reason: String
}
