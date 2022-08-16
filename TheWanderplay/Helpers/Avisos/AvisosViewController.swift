//
//  AvisosViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 29/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class AvisosViewController: UIViewController{
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var confetiContainer: AnimationView!
    
    var presenter: AvisosPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setAviso()
        
    }
    
    @objc
    func cerrarPopUp(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AvisosViewController: AvisoProtocol{
    func paintView(view: UIView) {
        messageContainer.addSubview(view)
        view.leadingAnchor.constraint(equalTo: messageContainer.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: messageContainer.trailingAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: messageContainer.heightAnchor).isActive = true
        messageContainer.addShadowInContainerView()
    }
    
    func closeAviso() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
