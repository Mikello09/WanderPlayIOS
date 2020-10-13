//
//  ApiBase.swift
//  Viajero
//
//  Created by Mikel Lopez on 04/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

typealias JSONDictionary = [String: Any]

enum ApiStatus: String {
    case ok = "OK"
    case fail = "Fail"
    case unathorized = "Unauthorized"
    case SQLError = "SQLError"
    
    func value() -> String{
        switch self {
            case .ok:
                return self.rawValue
            case .unathorized:
                return self.rawValue
            case .SQLError:
                return self.rawValue
            case .fail:
                return self.rawValue
            }
    }
}

class ApiBase{
    
    let baseUrl = Bundle.main.object(forInfoDictionaryKey: "baseUrl") as! String
    
}
