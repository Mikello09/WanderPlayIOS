//
//  WelcomePresenter.swift
//  Viajero
//
//  Created by Mikel Lopez on 29/04/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

enum WelcomeStep{
    case greeting
    case userName
    case password
    case resume
    case avatar
}

enum WelcomeDirection{
    case forward
    case backwards
}

protocol WelcomePresenterProtocol{
    func showNextStep(step: WelcomeStep?)
}

class WelcomePresenter{
    
    var delegate: WelcomePresenterProtocol?
    
    var actualStep: WelcomeStep?
    
    func getNextStep(direction: WelcomeDirection){
        guard let actualStep = actualStep else {
            self.actualStep = .greeting
            delegate?.showNextStep(step: .greeting)
            return
        }
        
        switch direction{
            case .forward:
                switch actualStep {
                    case .greeting:
                        delegate?.showNextStep(step: .userName)
                        self.actualStep = .userName
                    case .userName:
                        delegate?.showNextStep(step: .password)
                        self.actualStep = .password
                    case .password:
                        delegate?.showNextStep(step: .resume)
                        self.actualStep = .resume
                    case .resume:
                        delegate?.showNextStep(step: .avatar)
                        self.actualStep = .avatar
                    case .avatar:
                        return
            }
            case .backwards:
                switch actualStep {
                    case .greeting:
                        delegate?.showNextStep(step: nil)
                        self.actualStep = .greeting
                    case .userName:
                        delegate?.showNextStep(step: .greeting)
                        self.actualStep = .greeting
                    case .password:
                        delegate?.showNextStep(step: .userName)
                        self.actualStep = .userName
                    case .resume:
                        delegate?.showNextStep(step: .password)
                        self.actualStep = .password
                    case .avatar:
                        return
                }
            }
        }
    }
