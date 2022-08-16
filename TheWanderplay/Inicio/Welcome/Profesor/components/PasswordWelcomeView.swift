//
//  PasswordWelcomeView.swift
//  Viajero
//
//  Created by Mikel Lopez on 30/04/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol PasswordWelcomeViewProtocol{
    func contrasenaIntroducida(pass: String?)
}

class PasswordWelcomeView: UIView{
    @IBOutlet var container: UIView!
    @IBOutlet weak var texto: UILabel!
    @IBOutlet weak var passField: UITextField!
    
    var delegate: PasswordWelcomeViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {
        Bundle.main.loadNibNamed("PasswordWelcomeView", owner: self, options: nil)
        container.frame = bounds
        self.addSubview(self.container)
    }
    
    func configure(texto: [String], delegate: PasswordWelcomeViewProtocol?){
        self.delegate = delegate
        self.passField.delegate = self
        
        self.texto.animate(allTexts: texto, characterDelay: 0.05, delegate: self)
    }
    
    
}

extension PasswordWelcomeView: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.contrasenaIntroducida(pass: self.passField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.container.endEditing(true)
        return false
    }
}

extension PasswordWelcomeView: ProfesorViewAnimateTextProtocol{
    func textAnimationHasFinished() {
        self.passField.isHidden = false
    }
}
