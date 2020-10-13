//
//  ProfesorView.swift
//  Viajero
//
//  Created by Mikel Lopez on 27/04/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import SpriteKit

protocol ProfesorViewProtocol{
    func showNextButton()
    func hideNextButton()
    func showBackButton()
    func hideBackButton()
    func updateName(nombre: String?)
    func updatePass(password: String?)
}

protocol ProfesorViewAnimateTextProtocol{
    func textAnimationHasFinished()
}

enum TipoProfesor {
    case saluda
    case habla
}

class ProfesorView: UIView{
    
    @IBOutlet var container: UIView!
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var bocadilloView: UIView!
    
    var delegate: ProfesorViewProtocol?
    
    let profesorSaluda: SCNScene = SCNScene(named: "Profesor_Saluda")!
    let profesorHabla: SCNScene = SCNScene(named: "Profesor_Habla")!
    
    var filtroTutorialView: FiltroTutorialView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("ProfesorView", owner: self, options: nil)
        container.frame = bounds
        self.addSubview(self.container)
    }
    
    
    func configure(delegate: ProfesorViewProtocol? = nil){
        
        self.delegate = delegate
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        container.isUserInteractionEnabled = true
        container.addGestureRecognizer(tap)
        
        let bubbleImageSize = CGSize(width: bocadilloView.frame.width, height: bocadilloView.frame.height)
        let outgoingMessageView = UIImageView(frame:
            CGRect(x: 0,
                   y: 0,
                   width: bubbleImageSize.width,
                   height: bubbleImageSize.height))
        outgoingMessageView.tag = 1992
        let bubbleImage = UIImage(named: "speech_bubble")?
            .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                            resizingMode: .stretch)
            .withRenderingMode(.alwaysTemplate)
        outgoingMessageView.tintColor = Colors.amarillo
        outgoingMessageView.image = bubbleImage
        outgoingMessageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        outgoingMessageView.addShadowInContainerView(withBorder: false)
        bocadilloView.addSubview(outgoingMessageView)
        bocadilloView.sendSubviewToBack(outgoingMessageView)
        
    }
    
    func setScene(profesor: TipoProfesor){
        switch profesor {
        case .habla:
            sceneView.present(profesorHabla, with: .fade(withDuration: 0.05), incomingPointOfView: nil)
            sceneView.loops = true
            sceneView.isPlaying = true
            
            let omniLightNode = SCNNode()
            omniLightNode.light = SCNLight()
            omniLightNode.light!.type = .omni
            omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
            omniLightNode.position = SCNVector3Make(0, 300, 200)
            profesorHabla.rootNode.addChildNode(omniLightNode)
        case .saluda:
            sceneView.present(profesorSaluda, with: .fade(withDuration: 0.05), incomingPointOfView: nil)
            sceneView.loops = true
            sceneView.isPlaying = true
            
            let omniLightNode = SCNNode()
            omniLightNode.light = SCNLight()
            omniLightNode.light!.type = .omni
            omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
            omniLightNode.position = SCNVector3Make(0, 300, 200)
            profesorSaluda.rootNode.addChildNode(omniLightNode)
        }
        //Falta rotar la camara
    }
    
    func collada2SCNNode(filepath:String) -> SCNNode {
        var node = SCNNode()
        let scene = SCNScene(named: filepath)
        var nodeArray = scene!.rootNode.childNodes

        for childNode in nodeArray {
            node.addChildNode(childNode as SCNNode)
        }
        return node
    }
    
    func setUpWelcomeMessage(step: WelcomeStep, nombre: String? = nil){
        switch step {
        case .greeting:
            setScene(profesor: .saluda)
            bocadilloView.subviews.forEach{if $0.tag != 1992 {$0.removeFromSuperview()}}
            delegate?.hideNextButton()
            let greetingWelcomView: GreetingWelcomeView = GreetingWelcomeView(frame: self.bocadilloView.frame)
            greetingWelcomView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            bocadilloView.addSubview(greetingWelcomView)
            greetingWelcomView.configure(texto: ["Hola! Soy el Doctor Zurrón y voy a ser tu guía durante esta aventura.", "Tras largos años de estudio mi concimiento sobre los lugares del mundo es muy amplio y voy a compartirlo contigo.","¿Estás preparado?"], delegate: self)
        case .userName:
            setScene(profesor: .habla)
            bocadilloView.subviews.forEach{if $0.tag != 1992 {$0.removeFromSuperview()}}
            delegate?.hideNextButton()
            let userNameWelcomeView: UserNameWelcomeView = UserNameWelcomeView(frame: self.bocadilloView.frame)
            userNameWelcomeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            bocadilloView.addSubview(userNameWelcomeView)
            userNameWelcomeView.configure(texto: ["Muy bien!!", "Lo primero que voy a necesitar será que me digas quien eres.","¿Cómo te llamas?"], delegate: self)
        case .password:
            bocadilloView.subviews.forEach{if $0.tag != 1992 {$0.removeFromSuperview()}}
            delegate?.hideNextButton()
            let passwordWelcomeView: PasswordWelcomeView = PasswordWelcomeView(frame: self.bocadilloView.frame)
            passwordWelcomeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            bocadilloView.addSubview(passwordWelcomeView)
            passwordWelcomeView.configure(texto: ["Encantado de conocerte \(nombre!).", "Ahora introduce una contraseña para poder acceder a WanderPlay."], delegate: self)
        case .resume:
            bocadilloView.subviews.forEach{if $0.tag != 1992 {$0.removeFromSuperview()}}
            delegate?.hideNextButton()
            let resumenWelcomeView: ResumeWelcomeView = ResumeWelcomeView(frame: self.bocadilloView.frame)
            resumenWelcomeView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            bocadilloView.addSubview(resumenWelcomeView)
            resumenWelcomeView.configure(texto: ["Perfecto \(nombre!)!! Ya estamos listos para el siguiente paso.","Lo siguiente que tenemos que hacer será escoger el avatar que vamos a utilizar.", "Los distintos avatares tienen diferentes cualidades por lo que tendrás que escoger el que más se adecue a ti.", "Suerte!!!"], delegate: self)
        case .avatar:
            return
        }
    }
    
    @objc
    func hideKeyboard(){
        self.container.endEditing(true)
    }
}

extension ProfesorView:GreetingWelcomeViewProtocol,UserNameWelcomeViewProtocol, PasswordWelcomeViewProtocol, ResumenWelcomeViewProtocol{
    func textoResumenHasFinished() {
        delegate?.showNextButton()
    }
    
    func contrasenaIntroducida(pass: String?) {
        delegate?.updatePass(password: pass)
        if let passUsuario = pass, passUsuario != ""{delegate?.showNextButton()}else{delegate?.hideNextButton()}
    }
    
    func nombreIntroducido(nombre: String?) {
        delegate?.updateName(nombre: nombre)
        if let nombreUsuario = nombre, nombreUsuario != ""{delegate?.showNextButton()}else{delegate?.hideNextButton()}
    }
    
    func textHasFinished() {
        delegate?.showNextButton()
    }
}

extension UILabel {

    func animate(allTexts: [String], characterDelay: TimeInterval, delegate: ProfesorViewAnimateTextProtocol?) {

        DispatchQueue.main.async {
            
            self.text = ""
            var timeInterval: TimeInterval = 0.0
            for (i, texto) in allTexts.enumerated(){
                if i != 0{
                    timeInterval = Double(allTexts[i-1].count) * characterDelay + timeInterval + 1
                }
                for (index, character) in texto.enumerated() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index) + timeInterval) {
                        if index == 0 {self.text = ""}
                        self.text?.append(character)
                        if (i == (allTexts.count - 1)) && (index == texto.count - 1){delegate?.textAnimationHasFinished()}
                    }
                }
            }
            
        }
    }

}
