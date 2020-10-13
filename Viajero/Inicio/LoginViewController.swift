//
//  LoginViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 05/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: BaseViewController{
    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var jugarBoton: UIButton!
    @IBOutlet weak var yaTengoUsuarioBoton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jugarBoton.layer.shadowColor = UIColor.gray.cgColor
        jugarBoton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        jugarBoton.layer.shadowOpacity = 1.0
        jugarBoton.layer.shadowRadius = 3.0
        jugarBoton.layer.masksToBounds = false
        
        yaTengoUsuarioBoton.layer.borderWidth = 2
        yaTengoUsuarioBoton.layer.borderColor = Colors.azul.cgColor
        yaTengoUsuarioBoton.layer.cornerRadius = 3
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func jugarClicked(_ sender: UIButton) {
        WelcomeRouter().goToWelcome(navigationController: self.navigationController)
        //ChooseAvatarRouter().goToChooseAvatar(navigationController: self.navigationController, nombre: "Mikel", pass: "asdfgh")
    }
    
    @IBAction func yaTengoUsuarioClicked(_ sender: UIButton) {
        LoginManualRouter().goToLoginManual(navigationController: self.navigationController)
    }
}
