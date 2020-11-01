//
//  LogrosViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 14/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import SpriteKit
import Lottie

class LogrosViewController: BaseViewController{
    
    @IBOutlet weak var lugarImage: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var showView: UIView!
    @IBOutlet weak var cintaView: UIView!
    @IBOutlet weak var fireworksView: AnimationView!
    
    var logros: [Logro] = []
    var resumenCartasView = ResumenCartasView()
    var avatarView = SCNView()
    
    var presenter: LogrosPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.getLugarImage()
        
        setUpView()
        
        //UPDATE USUARIO
        presenter?.updateUsuario()
        for logro in logros{
            Usuario.shared.monedas += logro.monedas ?? 0
            Usuario.shared.diamantes += logro.diamantes ?? 0
            Usuario.shared.puntos += logro.puntos ?? 0
        }
        ///
        
        let seconds = 6.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.finished()
        }
        
    }
    
    func setUpView(){
        //set rectangular image
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 30, y: 200))
        path.addLine(to: CGPoint(x: 270, y: 200))
        path.addLine(to: CGPoint(x: 300, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        let mask = CAShapeLayer()
        mask.frame = lugarImage.bounds
        mask.path = path.cgPath
        
        lugarImage.layer.mask = mask
        
        cintaView.addShadowInContainerView()
    }
    
    func paintAvatar(){
        avatarView = SCNView(frame: CGRect(x: 0, y: 0, width: showView.frame.width, height: showView.frame.height))
        
        let bigAvatar: SCNScene = SCNScene(named: Usuario.shared.getAvatarActivoDancing())!
        avatarView.present(bigAvatar, with: .fade(withDuration: 0.05), incomingPointOfView: nil)
        avatarView.loops = true
        avatarView.isPlaying = true
        
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = .omni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 300, 200)
        bigAvatar.rootNode.addChildNode(omniLightNode)
        
        avatarView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        avatarView.translatesAutoresizingMaskIntoConstraints = true
        avatarView.backgroundColor = .clear
        showView.addSubview(avatarView)
        
        fireworksView.animation = Animation.named("fireworks")
        fireworksView.loopMode = .loop
        fireworksView.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        paintAvatar()
    }
    
}

extension LogrosViewController: LogrosPresenterProtocol{
    
    func paintLugarImagen(imagen: String) {
        if let url = URL(string: imagen), let data = try? Data(contentsOf: url){
            lugarImage.image = UIImage(data: data)
        }
    }
    
    func paintTitle(title: String){
        tituloLabel.text = title
    }
    
    func showError() {
        //no se si habria que mostrar un pop up de error
        self.navigationController?.popViewController(animated: false)
    }
}

extension LogrosViewController: MostrarCartasViewProtocol, ResumenCartasProtocol{
    func okClicked() {
        self.navigationController?.popViewController(animated: false)
    }
    
    func finished() {
        let resumenCartasView = ResumenCartasView(frame: CGRect(x: 0, y: 0, width: showView.frame.width, height: showView.frame.height))
        resumenCartasView.configure(delegate: self, logros: logros)
        resumenCartasView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        resumenCartasView.translatesAutoresizingMaskIntoConstraints = true
        
        
        avatarView.isHidden = true
        fireworksView.stop()
        fireworksView.isHidden = true
        showView.addSubview(resumenCartasView)
        
        
        
    }
}
