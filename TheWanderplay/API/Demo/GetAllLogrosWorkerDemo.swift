//
//  GetAllLogrosWorkerDemo.swift
//  Viajero Demo
//
//  Created by Mikel Lopez on 27/01/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


protocol GetAllLogrosWorkerProtocol{
    func successAllLogros()
    func failAllLogros()
}

class GetAllLogrosWorker{
    
    var delegate: GetAllLogrosWorkerProtocol?
    
    func execute(delegate: GetAllLogrosWorkerProtocol){
        self.delegate = delegate
        self.delegate?.successAllLogros()
    }
}
