//
//  CamerinosViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 12/09/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import SpriteKit
import Lottie



enum EstadoAvatarCamerino {
    case jugando
    case jugar
    case comprar
}

class CamerinosViewController: BaseViewController{
    
    
    @IBOutlet weak var topBar: TopBarOnlyBack!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var categoriasStack: UIStackView!
    @IBOutlet weak var estadoView: UIView!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var nombreAvatar: UILabel!
    @IBOutlet weak var avatarScene: SCNView!
    @IBOutlet weak var bloqueadoLabel: UILabel!
    @IBOutlet weak var bloqueadoView: UIView!
    @IBOutlet weak var confetiContainer: AnimationView!
    
    @IBOutlet weak var jugarView: UIView!
    @IBOutlet weak var jugandoView: UIView!
    @IBOutlet weak var comprarView: UIView!
    @IBOutlet weak var comprarBoton: UIButton!
    @IBOutlet weak var jugandoContainer: UIView!
    @IBOutlet weak var jugarBoton: UIButton!
    
    var avatares: [Avatar] = []
    var posicion: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar.setTitle(title: "Camerinos")
        topBar.delegate = self
        
        leftButton.shake()
        rightButton.shake()
        
        self.showLoader()
        AvatarWorker().getAllAvatares(delegate: self)
        
        jugandoContainer.layer.borderWidth = 2
        jugandoContainer.layer.borderColor = Colors.azul.cgColor
        comprarBoton.addShadowInContainerView(withRadius: 20, withBorder: false)
        jugarBoton.addShadowInContainerView(withRadius: 20, withBorder: false)
        
    }
    
    func changeAvatarInfo(){
        hideConfeti()
        if posicion == 0{
            leftButton.isHidden = true
        } else {
            leftButton.isHidden = false
        }
        if posicion == (avatares.count - 1){
            rightButton.isHidden = true
        } else {
            rightButton.isHidden = false
        }
        
        if avatares[posicion].nombre == Usuario.shared.avatarActivo{
            crearEstado(estado: .jugando, avatar: avatares[posicion])
        } else if Usuario.shared.avatares.contains(avatares[posicion].nombre ?? "")  {
            crearEstado(estado: .jugar, avatar: avatares[posicion])
        } else {
            crearEstado(estado: .comprar, avatar: avatares[posicion])
        }
        
        if Usuario.shared.nivel < avatares[posicion].nivel ?? 0{
            createBloqueado(nivel: avatares[posicion].nivel ?? 0)
        } else {
            bloqueadoView.isHidden = true
        }
        
        añadirCategorias(categorias: avatares[posicion].categorias)
        
        nombreAvatar.text = avatares[posicion].nombre
        descripcionLabel.text = avatares[posicion].descripcion
        descripcionLabel.sizeToFit()
        let bigAvatar: SCNScene = SCNScene(named: avatares[posicion].getStanding())!
        avatarScene.present(bigAvatar, with: .fade(withDuration: 0.05), incomingPointOfView: nil)

        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = .omni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 300, 200)
        bigAvatar.rootNode.addChildNode(omniLightNode)
        
    }
    
    func createBloqueado(nivel: Int){
        bloqueadoLabel.text = "Necesario ser \n Nvl \(nivel)"
        bloqueadoView.isHidden = false
    }
    
    func añadirCategorias(categorias: [String]?){
        if let categorias = categorias{
            for subview in categoriasStack.subviews{
                subview.removeFromSuperview()
            }
            for categoria in categorias{
                var categoriaView: UIView = UIView()
                categoriaView.translatesAutoresizingMaskIntoConstraints = false
                
                
                var containerImagen: UIView = UIView()
                containerImagen.translatesAutoresizingMaskIntoConstraints = false
                containerImagen.backgroundColor = UIColor.white
                containerImagen.layer.cornerRadius = 30
                containerImagen.addShadowInContainerView(withRadius: 30, withBorder: false)
                categoriaView.addSubview(containerImagen)
                containerImagen.widthAnchor.constraint(equalToConstant: 60).isActive = true
                containerImagen.heightAnchor.constraint(equalToConstant: 60).isActive = true
                containerImagen.centerYAnchor.constraint(equalTo: categoriaView.centerYAnchor).isActive = true
                containerImagen.centerXAnchor.constraint(equalTo: categoriaView.centerXAnchor).isActive = true
                
                
                var imagenCategoria: UIImageView = UIImageView()
                imagenCategoria.translatesAutoresizingMaskIntoConstraints = false
                imagenCategoria.image = UIImage(named: categoria)
                categoriaView.addSubview(imagenCategoria)
                imagenCategoria.centerYAnchor.constraint(equalTo: containerImagen.centerYAnchor).isActive = true
                imagenCategoria.centerXAnchor.constraint(equalTo: containerImagen.centerXAnchor).isActive = true
                imagenCategoria.widthAnchor.constraint(equalToConstant: 30).isActive = true
                imagenCategoria.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
                
                categoriasStack.addArrangedSubview(categoriaView)
                
                categoriaView.heightAnchor.constraint(equalToConstant: 60).isActive = true
                categoriaView.widthAnchor.constraint(equalToConstant: 60).isActive = true
                
            }
        }
    }
    
    func crearEstado(estado: EstadoAvatarCamerino, avatar: Avatar){
        switch estado {
        case .jugando:
            jugandoView.isHidden = false
            jugarView.isHidden = true
            comprarView.isHidden = true
        case .jugar:
            jugandoView.isHidden = true
            jugarView.isHidden = false
            comprarView.isHidden = true
        case .comprar:
            comprarBoton.setTitle("\(avatar.precio ?? 0)", for: .normal)
            jugandoView.isHidden = true
            jugarView.isHidden = true
            comprarView.isHidden = false
        }
    }
    
    func showConfeti(){
        confetiContainer.isHidden = false
        confetiContainer.animation = Animation.named("confeti")
        confetiContainer.loopMode = .loop
        confetiContainer.play()
    }
    
    func hideConfeti(){
        confetiContainer.isHidden = true
    }
    
    @IBAction func leftButtonClicked(_ sender: UIButton) {
        posicion -= 1
        changeAvatarInfo()
    }
    
    @IBAction func rightButtonClicked(_ sender: UIButton) {
        posicion += 1
        changeAvatarInfo()
    }
    
    @IBAction func jugarClicked(_ sender: UIButton) {
        showLoader()
        CamerinosWorker().activarAvatar(avatar: avatares[posicion], delegate: self)
    }
    
    @IBAction func comprarClicked(_ sender: UIButton) {
        if Usuario.shared.nivel < avatares[posicion].nivel ?? 0{
            AvisosRouter().goToAvisoStandard(navigationController: self.navigationController, titulo: "Lo sentimos", mensaje: "Para poder jugar con \(avatares[posicion].nombre ?? "") necesitas tener al menos el nivel \(avatares[posicion].nivel ?? 0).", okAction: errorEntendido)
        } else if Usuario.shared.monedas ?? 0 < avatares[posicion].precio ?? 0{
            AvisosRouter().goToAvisoStandard(navigationController: self.navigationController, titulo: "Lo sentimos", mensaje: "Para poder jugar con \(avatares[posicion].nombre ?? "") necesitas tener \(avatares[posicion].precio ?? 0) monedas.", okAction: errorEntendido)
        } else {
            showLoader()
            CamerinosWorker().comprarAvatar(avatar: avatares[posicion], delegate: self)
        }
        
    }
    
    func errorEntendido(){
        
    }
    
    func compradoEntendido(){
        Usuario.shared.avatares.append(avatares[posicion].nombre ?? "")
        changeAvatarInfo()
        showConfeti()
    }
    
    func activadoEntendido(){
        Usuario.shared.avatarActivo = avatares[posicion].nombre ?? ""
        changeAvatarInfo()
    }
    
}

extension CamerinosViewController: GetAllAvataresProtocol{
    func success(avatares: [Avatar]) {
        DispatchQueue.main.async {
            self.hideLoader()
            self.avatares = avatares
            for (i,avatar) in avatares.enumerated(){
                if Usuario.shared.avatarActivo == avatar.nombre{
                    self.posicion = i
                }
            }
            self.changeAvatarInfo()
        }
    }
    
    func fail() {
        DispatchQueue.main.async {
            self.hideLoader()
            self.navigationController?.popViewController(animated: false)
        }
    }
}

extension CamerinosViewController: CamerinosWorkerProtocol{
    func comprado() {
        DispatchQueue.main.async {
            self.hideLoader()
            AvisosRouter().goToAvisoStandard(navigationController: self.navigationController,
                                             titulo: "Enhorabuena",
                                             mensaje: "Has comprado a \(self.avatares[self.posicion].nombre ?? "")!!!",
                                             okAction: self.compradoEntendido)
        }
    }
    
    func activado() {
        DispatchQueue.main.async {
            self.hideLoader()
            AvisosRouter().goToAvisoStandard(navigationController: self.navigationController,
                                             titulo: "Enhorabuena", mensaje: "Has activado a \(self.avatares[self.posicion].nombre ?? "")!!! A jugar!!",
                                             okAction: self.activadoEntendido)
        }
    }
    
    func failCamerino(){
        DispatchQueue.main.async {
            self.hideLoader()
            AvisosRouter().goToAvisoStandard(navigationController: self.navigationController,
                                             titulo: "Lo sentimos",
                                             mensaje: "Ha ocurrido un error. Vuelva a intentarlo.",
                                             okAction: self.errorEntendido)
        }
    }
    
}

extension CamerinosViewController: TopBarOnlyBackProtocol{
    func atrasClicked() {
        self.navigationController?.popViewController(animated: false)
    }
}


extension UIButton {

    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 1
        animation.repeatCount = .infinity
        animation.values = [0.0, -5.0, 5.0]
        //animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
