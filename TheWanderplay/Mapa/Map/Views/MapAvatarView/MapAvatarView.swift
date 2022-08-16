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
    @IBOutlet weak var avatarView: SCNView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var circularContainer: CircularProgressView!
    
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
        
        for node in avatarView.scene?.rootNode.childNodes ?? []{
            node.removeFromParentNode()
        }
        
        let bigAvatar: SCNScene = SCNScene(named: Usuario.shared.getAvatarActivoStanding())!
        avatarView.present(bigAvatar, with: .fade(withDuration: 0.05), incomingPointOfView: nil)
        avatarView.loops = true
        avatarView.isPlaying = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarSelected))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        
        view.layoutIfNeeded()
        circularContainer.makeCircularPath()
    }
    
    func updateLevel() {
        circularContainer.setProgressWithAnimation(duration: 0.3, value: Usuario.shared.getNivelPorcentaje())
        levelLabel.text = Usuario.shared.getNivel()
    }
    
    @objc
    func avatarSelected() {
        delegate?.onMapAvatarViewSelected()
    }
}
