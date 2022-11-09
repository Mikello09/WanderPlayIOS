//
//  LoginInteractor.swift
//  TheWanderplay
//
//  Created by Mikel Lopez Salazar on 5/11/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation

class LoginInteractor {
    
    func getLoginData() {
        DispatchQueue.global(qos: .background).async {
            LoginWorker().execute(nombre: Usuario.shared.nombre,
                                  pass: Usuario.shared.contrasena,
                                  delegate: self)
        }
    }
    
}

extension LoginInteractor: LoginWorkerProtocol {
    func success() { () }
    
    func fail(error: String) { () }
}
