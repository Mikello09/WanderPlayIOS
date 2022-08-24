//
//  LugaresCached.swift
//  Viajero
//
//  Created by Mikel Lopez on 30/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation


enum KeyLugares:String {
    case jsonLugares = "jsonLugares"
}


class LugaresCached: NSObject, NSCoding, NSSecureCoding {
    
    var jsonLugaresData: JSONDictionary? = nil
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    @objc init(jsonLugaresData: JSONDictionary) {
        super.init()
        self.jsonLugaresData = jsonLugaresData
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(jsonLugaresData as? JSONDictionary, forKey: KeyLugares.jsonLugares.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let jsonLugaresData = aDecoder.decodeObject(forKey: KeyLugares.jsonLugares.rawValue) as! JSONDictionary
        self.init(jsonLugaresData: jsonLugaresData)
    }
    
}
