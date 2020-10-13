//
//  LugaresWorkerDemo.swift
//  Viajero Demo
//
//  Created by Mikel Lopez on 25/01/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


protocol LugaresWorkerProtocol{
    func success()
    func fail()
}

class LugaresWorker{
    
    var delegate: LugaresWorkerProtocol?
    
    func execute(delegate: LugaresWorkerProtocol){
        self.delegate = delegate
        self.delegate?.success()
    }
    
}
