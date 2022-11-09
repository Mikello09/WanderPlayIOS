//
//  MapAvatarView.swift
//  Viajero
//
//  Created by Mikel Lopez Salazar on 17/7/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

protocol MapAvatarViewProtocol {
    func onMapAvatarViewSelected()
}

class MapAvatarView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var actualLevelView: UIView!
    @IBOutlet weak var levelProgress: UIProgressView!
    @IBOutlet weak var actualLevelLabel: UILabel!
    
    var delegate: MapAvatarViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("MapAvatarView", owner: self, options: nil)
        view.frame = bounds
        self.addSubview(self.view)
    }
    
    func configure(delegate: MapAvatarViewProtocol) {
        self.delegate = delegate
        // Container
        container.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        container.layer.cornerRadius = 8
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.systemBrown.cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarSelected))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        // User name
        userName.text = Usuario.shared.nombre
        // Avatar Image
        avatarImage.image = UIImage(named: "Mikel")
        // ActualLevel
        actualLevelView.layer.cornerRadius = 4
        actualLevelLabel.text = "\(Usuario.shared.nivel)"
        // Level Progress
        levelProgress.layer.cornerRadius = 4
        levelProgress.layer.borderColor = UIColor.systemBrown.cgColor
        levelProgress.layer.borderWidth = 1
        levelProgress.setProgress(Usuario.shared.getNivelPorcentaje(), animated: true)
    }
    
    func updateLevel() {
        actualLevelLabel.text = "\(Usuario.shared.nivel)"
        levelProgress.setProgress(Usuario.shared.getNivelPorcentaje(), animated: true)
    }
    
    @objc
    func avatarSelected() {
        delegate?.onMapAvatarViewSelected()
    }
}
