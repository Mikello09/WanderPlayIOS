//
//  ResumeWelcomView.swift
//  Viajero
//
//  Created by Mikel Lopez on 30/04/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol ResumenWelcomeViewProtocol{
    func textoResumenHasFinished()
}

class ResumeWelcomeView: UIView{
    @IBOutlet var container: UIView!
    @IBOutlet weak var texto: UILabel!
    
    var delegate: ResumenWelcomeViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {
        Bundle.main.loadNibNamed("ResumeWelcomeView", owner: self, options: nil)
        container.frame = bounds
        self.addSubview(self.container)
    }
    
    func configure(texto: [String], delegate: ResumenWelcomeViewProtocol?){
        self.delegate = delegate
        self.texto.animate(allTexts: texto, characterDelay: 0.05, delegate: self)
    }
    
}

extension ResumeWelcomeView: ProfesorViewAnimateTextProtocol{
    func textAnimationHasFinished() {
        delegate?.textoResumenHasFinished()
    }
}
