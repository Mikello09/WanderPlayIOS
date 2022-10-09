//
//  InitPresenter.swift
//  TheWanderplay
//
//  Created by Mikel Lopez Salazar on 25/9/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

enum InitState {
    case location
    case user
    case lugares
    case finished
    case error
}

protocol InitPresenterProtocol: AnyObject {
    func changeState(state: InitState)
    func goToMap()
}

class InitPresenter {
    
    weak var delegate: InitPresenterProtocol?
    var locationEngine: LocationEngine!
    
    func searchForLocation() {
        delegate?.changeState(state: .location)
        locationEngine = LocationEngine.sharedInstance()
        locationEngine.startEngineForPermission(delegate: self)
    }
    
    func doLogin() {
        LoginWorker().execute(nombre: Usuario.shared.getNombreCredencial() ?? "",
                              pass: Usuario.shared.getPassCredencial() ?? "",
                              delegate: self)
    }
}

// MARK: LOCATION
extension InitPresenter: LocationEnginePermission {
    func notDetermined() {
        locationEngine.askPermision()
    }
    
    func accepted() {
        delegate?.changeState(state: .user)
        doLogin()
    }
    
    func denied() {
        delegate?.changeState(state: .error)
    }
}

// MARK: LOGIN
extension InitPresenter: LoginWorkerProtocol {
    func success(settings: Settings) {
        delegate?.changeState(state: .lugares)
        Task.init {
            let result = await LugarWorker().getLugares(settings: settings)
            await MainActor.run {
                if result {
                    delegate?.changeState(state: .finished)
                    delegate?.goToMap()
                } else {
                    delegate?.changeState(state: .error)
                }
            }
        }
    }
    
    func fail(error: String) {
        delegate?.changeState(state: .error)
    }
}
