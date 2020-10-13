//
//  GreetingWelcomView.swift
//  Viajero
//
//  Created by Mikel Lopez on 29/04/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol GreetingWelcomeViewProtocol{
    func textHasFinished()
}

class GreetingWelcomeView: UIView{
    
    @IBOutlet var container: UIView!
    @IBOutlet weak var texto: UILabel!
    
    var delegate: GreetingWelcomeViewProtocol?
    
    func configure(texto: [String], delegate: GreetingWelcomeViewProtocol){
     
        self.delegate = delegate
        self.texto.animate(allTexts: texto, characterDelay: 0.05, delegate: self)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("GreetingWelcomeView", owner: self, options: nil)
        container.frame = bounds
        self.addSubview(self.container)
    }
}

extension GreetingWelcomeView: ProfesorViewAnimateTextProtocol{
    func textAnimationHasFinished() {
        self.delegate?.textHasFinished()
    }
}
