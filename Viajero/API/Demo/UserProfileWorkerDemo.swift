//
//  UserProfileWorkerDemo.swift
//  Viajero Demo
//
//  Created by Mikel Lopez on 25/01/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


protocol UserProfileProtocol{
    func success()
    func fail()
}

class UserProfileWorker: ApiBase{

    
    var delegate: UserProfileProtocol?
    
    func execute(delegate: UserProfileProtocol) {
        self.delegate = delegate
        self.delegate?.success()
    }
    
}
