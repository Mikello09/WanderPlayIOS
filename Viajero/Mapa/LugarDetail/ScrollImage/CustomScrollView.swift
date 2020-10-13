//
//  CustomScrollView.swift
//  Viajero
//
//  Created by Mikel Lopez on 26/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class CustomScrollView: UIView{
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var image: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        Bundle.main.loadNibNamed("CustomScrollView", owner: self, options: nil)
        view.frame = bounds
        //image.contentMode = .scaleAspectFill
        self.addSubview(self.view)
    }
    
}
