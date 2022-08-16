//
//  Welcome.swift
//  Viajero
//
//  Created by Mikel Lopez on 29/04/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


class WelcomeViewController: UIViewController{
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var profesorContainer: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    var profesorView: ProfesorView?
    var presenter: WelcomePresenter?
    
    var nombre: String? = ""
    var pass: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        presenter?.getNextStep(direction: .forward)
    }
    
    func setUpView(){
        backButton.addShadowInContainerView()
        nextButton.addShadowInContainerView()
        
        profesorView = ProfesorView(frame: profesorContainer.frame)
        profesorView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        profesorView?.configure(delegate: self)
        profesorContainer.addSubview(profesorView!)
        
    }
    
    @IBAction func goNext(_ sender: UIButton) {
        presenter?.getNextStep(direction: .forward)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        presenter?.getNextStep(direction: .backwards)
    }
}

extension WelcomeViewController: WelcomePresenterProtocol{
    func showNextStep(step: WelcomeStep?) {
        guard let proximoPaso = step else {
            self.navigationController?.popViewController(animated: false)
            return
        }
        if proximoPaso == .avatar{
            ChooseAvatarRouter().goToChooseAvatar(navigationController: self.navigationController,
                                                  nombre: self.nombre,
                                                  pass: self.pass)
        } else {
            profesorView?.setUpWelcomeMessage(step: proximoPaso, nombre: self.nombre)
        }
    }
}

extension WelcomeViewController: ProfesorViewProtocol{
    func updatePass(password: String?) {
        self.pass = password
    }
    
    func updateName(nombre: String?) {
        self.nombre = nombre
    }
    
    func showNextButton() {
        nextButton.isHidden = false
    }
    
    func hideNextButton() {
        nextButton.isHidden = true
    }
    
    func showBackButton() {
        backButton.isHidden = false
    }
    
    func hideBackButton() {
        backButton.isHidden = true
    }
    
}
