//
//  LoginManualViewController.swift
//  Viajero
//
//  Created by usuario on 01/11/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


class LoginManualViewController: BaseViewController{
    
    @IBOutlet weak var topBar: TopBarOnlyBack!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var nombreField: UITextField!
    @IBOutlet weak var contrasenaField: UITextField!
    @IBOutlet weak var entrarBoton: UIButton!
    
    var presenter: LoginManualPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBar.titulo.text = "Logéate"
        topBar.delegate = self
        hideError()
        errorView.addShadowInContainerView()
    }
    
    @IBAction func entrarClicked(_ sender: Any) {
        if nombreField.text != "" || contrasenaField.text != ""{
            hideError()
            showLoader()
            presenter?.doLogin(nombre: nombreField.text ?? "", pass: contrasenaField.text ?? "")
        } else {
            showError(message: "Todos los campos tienen que estar completos.")
        }
    }
    
    func showError(message: String){
        errorMessage.text = message
        errorView.isHidden = false
    }
    
    func hideError(){
        errorMessage.text = ""
        errorView.isHidden = true
    }
}

extension LoginManualViewController: LoginManualPresenterProtocol{
    func loginOK() {
        hideLoader()
        InitRouter().goToInit(navigationController: self.navigationController)
    }
    
    func loginFail(reason: String) {
        hideLoader()
        showError(message: reason)
    }
}

extension LoginManualViewController: TopBarOnlyBackProtocol{
    func atrasClicked() {
        self.navigationController?.popViewController(animated: false)
    }
}


