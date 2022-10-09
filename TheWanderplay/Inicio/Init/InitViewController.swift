//
//  InitViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 06/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class InitViewController: BaseViewController{
    
    var presenter: InitPresenter?
    
    @IBOutlet weak var cargandoView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var errorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.searchForLocation()
    }
    
    func setupUI() {
        ()
    }
    
    func configureError(image: String, message: String, intentar: Bool){
        DispatchQueue.main.async {
            self.cargandoView.isHidden = true
            if intentar{
                self.errorButton.isHidden = false
                self.errorButton.setNormalStyle()
            } else {
                self.errorButton.isHidden = true
            }
            
            self.errorImage.image = UIImage(named: image)
            self.errorMessage.text = message
            self.errorView.isHidden = false
        }
    }
}

// MARK: PRESENTER
extension InitViewController: InitPresenterProtocol {
    func changeState(state: InitState) {
        DispatchQueue.main.async {
            switch state {
            case .location:
                self.progressLabel.text = "Calculando posicionamiento..."
                self.progressView.setProgress(0.25, animated: true)
            case .user:
                self.progressLabel.text = "Obteniendo datos de usuario..."
                self.progressView.setProgress(0.5, animated: true)
            case .lugares:
                self.progressLabel.text = "Preparando lugares..."
                self.progressView.setProgress(0.75, animated: true)
            case .finished:
                self.progressLabel.text = ""
                self.progressView.setProgress(1, animated: true)
            case .error:
                ()
            }
        }
    }
    func goToMap() {
        MapRouter().goToMap(navigationController: self.navigationController)
    }
}
