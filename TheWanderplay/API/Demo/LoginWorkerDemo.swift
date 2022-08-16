//
//  LoginWorkerDemo.swift
//  Viajero Demo
//
//  Created by Mikel Lopez on 25/01/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


protocol LoginWorkerProtocol {
    func success()
    func fail(reason: String)
}

class LoginWorker: ApiBase{

    var delegate: LoginWorkerProtocol?
    
    func execute(delegate: LoginWorkerProtocol, email: String?, contrasena: String?){
        self.delegate = delegate
        Usuario.shared.saveId(id: 1)
        self.delegate?.success()
    }
    
}
