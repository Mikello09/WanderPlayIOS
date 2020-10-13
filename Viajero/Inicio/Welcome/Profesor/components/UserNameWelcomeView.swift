//
//  UserNameWelcomeView.swift
//  Viajero
//
//  Created by Mikel Lopez on 30/04/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol UserNameWelcomeViewProtocol{
    func nombreIntroducido(nombre: String?)
}

class UserNameWelcomeView: UIView{
    
    @IBOutlet var container: UIView!
    @IBOutlet weak var texto: UILabel!
    @IBOutlet weak var nombreField: UITextField!
    
    var delegate: UserNameWelcomeViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("UserNameWelcomeView", owner: self, options: nil)
        container.frame = bounds
        self.addSubview(self.container)
    }
    
    func configure(texto: [String], delegate: UserNameWelcomeViewProtocol?){
        self.delegate = delegate
        self.nombreField.delegate = self
        self.texto.animate(allTexts: texto, characterDelay: 0.05, delegate: self)
    }
}

extension UserNameWelcomeView: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.nombreIntroducido(nombre: self.nombreField.text?.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.container.endEditing(true)
        return false
    }
}

extension UserNameWelcomeView: ProfesorViewAnimateTextProtocol{
    func textAnimationHasFinished() {
        self.nombreField.isHidden = false
    }
}
