//
//  LogroWorkerDemo.swift
//  Viajero Demo
//
//  Created by Mikel Lopez on 27/01/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol LogroWorkerProtocol{
    func logroSuccess(logros: [Logro], lugar: Int)
    func logroFail()
}

class LogroWorker{
    
    var delegate: LogroWorkerProtocol?
    
    func execute(delegate: LogroWorkerProtocol, idLugar: String){
        self.delegate = delegate
        self.delegate?.logroFail()
    }
    
}
