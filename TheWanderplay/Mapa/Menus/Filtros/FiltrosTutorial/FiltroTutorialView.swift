//
//  FiltroTutorialView.swift
//  Viajero
//
//  Created by Mikel Lopez on 17/05/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


protocol FiltroTutorialViewProtocol{
    func filtroTutorialtextHasFinished()
}

class FiltroTutorialView: UIView{
    
    var delegate: FiltroTutorialViewProtocol?
    @IBOutlet var container: UIView!
    @IBOutlet weak var texto: UILabel!
    @IBOutlet weak var pinesResumenView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("FiltroTutorialView", owner: self, options: nil)
        container.frame = bounds
        self.addSubview(self.container)
    }
    
    func configure(texto: [String], delegate: FiltroTutorialViewProtocol){
     
        self.delegate = delegate
        self.texto.animate(allTexts: texto, characterDelay: 0.05, delegate: self)
        
    }
    
    func showPinesResumen(){
        texto.isHidden = true
        pinesResumenView.isHidden = false
    }
    
}

extension FiltroTutorialView: ProfesorViewAnimateTextProtocol{
    func textAnimationHasFinished() {
        self.delegate?.filtroTutorialtextHasFinished()
    }
    
}
