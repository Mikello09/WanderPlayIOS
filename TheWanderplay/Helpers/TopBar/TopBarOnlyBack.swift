//
//  TopBarOnlyBack.swift
//  Viajero
//
//  Created by Mikel Lopez on 03/12/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol TopBarOnlyBackProtocol{
    func atrasClicked()
}

class TopBarOnlyBack: UIView{
    @IBOutlet var view: UIView!
    @IBOutlet weak var atrasBoton: UIButton!
    @IBOutlet weak var titulo: UILabel!
    
    var delegate: TopBarOnlyBackProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("TopBarOnlyBack", owner: self, options: nil)
        view.frame = bounds
        self.addSubview(self.view)
    }
    
    func setTitle(title: String){
        self.titulo.text = title
    }
    
    @IBAction func atrasClicked(_ sender: UIButton) {
        delegate?.atrasClicked()
    }
}
