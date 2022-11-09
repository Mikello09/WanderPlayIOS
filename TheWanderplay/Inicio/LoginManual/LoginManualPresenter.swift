//
//  LoginManualPresenter.swift
//  Viajero
//
//  Created by Mikel Lopez on 28/08/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit




protocol LoginManualPresenterProtocol{
    func loginOK()
    func loginFail(reason: String)
}

class LoginManualPresenter{
    
    var delegate: LoginManualPresenterProtocol?
    
    func doLogin(nombre: String, pass: String){
        LoginWorker().execute(nombre: nombre, pass: pass, delegate: self)
    }
}

extension LoginManualPresenter: LoginWorkerProtocol {
    func success() {
        delegate?.loginOK()
    }
    
    func fail(error: String) {
        delegate?.loginFail(reason: error)
    }
    
    
}
