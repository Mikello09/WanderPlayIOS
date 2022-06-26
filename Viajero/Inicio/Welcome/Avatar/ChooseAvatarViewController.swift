//
//  ChooseAvatarViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 01/05/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import SpriteKit


class ChooseAvatarViewController: BaseViewController{
    @IBOutlet weak var avatarName: UILabel!
    @IBOutlet weak var avatarScene: SCNView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var interesesCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var confirmarButton: UIButton!
    @IBOutlet weak var descripcionLabel: UILabel!
    
    var presenter: ChooseAvatarPresenter?
    var avatares: [Avatar] = []
    var selectedAvatar: Avatar?
    var interesesActuales: [TipoCategorias] = []
    
    
    var nombre: String?
    var pass: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showLoader()
        presenter?.getAvatares()
        
        backButton.addShadowInContainerView()
        confirmarButton.addShadowInContainerView()
    }
    
    func setSelectedAvatar(avatar: Avatar){
        self.selectedAvatar = avatar
        if let av = selectedAvatar{
            avatarName.text = av.nombre ?? ""
            
            for node in avatarScene.scene?.rootNode.childNodes ?? []{
                node.removeFromParentNode()
            }
            
            let bigAvatar: SCNScene = SCNScene(named: av.getDancing())!
            avatarScene.present(bigAvatar, with: .fade(withDuration: 0.05), incomingPointOfView: nil)
            avatarScene.loops = true
            avatarScene.isPlaying = true
            
            let omniLightNode = SCNNode()
            omniLightNode.light = SCNLight()
            omniLightNode.light!.type = .omni
            omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
            omniLightNode.position = SCNVector3Make(0, 300, 200)
            bigAvatar.rootNode.addChildNode(omniLightNode)
            
            collectionView.reloadData()
            self.interesesActuales = av.getTipoCategorias()
            interesesCollectionView.reloadData()
            self.descripcionLabel.text = av.descripcion
        }
        
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func confirmarClicked(_ sender: UIButton) {
        
        if let avatar = self.selectedAvatar{
            self.showLoader()
            RegistroWorker().registrarse(nombre: self.nombre ?? "",
                                         pass: self.pass ?? "",
                                         avatar: avatar.nombre ?? "",
                                         delegate: self)
        }
    }
    
}

extension ChooseAvatarViewController: ChooseAvatarPresenterProtocol{
    func getAvatares(avatares: [Avatar]) {
        DispatchQueue.main.async {
            self.hideLoader()
            self.avatares = avatares
            self.collectionView.reloadData()
            self.setSelectedAvatar(avatar: avatares[0])
        }
    }
    
    func failGettingAvatars() {
        print("ERROR GETTING AVATARS")
    }
}

extension ChooseAvatarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView{
            return self.avatares.count
        } else {
            return self.interesesActuales.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarChooseCell", for: indexPath) as! AvatarChooseCell
            cell.configure(delegate: self,
                           avatar: self.avatares[indexPath.row],
                           seleccionado: self.selectedAvatar?.nombre == self.avatares[indexPath.row].nombre)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interesesCell", for: indexPath) as! InteresesCell
            cell.configure(tipoInteres: self.interesesActuales[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView{
            return CGSize(width: (UIScreen.main.bounds.width - 48)/3 , height: (UIScreen.main.bounds.width - 48)/3)
        } else {
            return CGSize(width: 50, height: 50)
        }
        
    }
    
}

extension ChooseAvatarViewController: AvatarChooseCellProtocol{
    func avatarChoosen(avatar: Avatar) {
        self.setSelectedAvatar(avatar: avatar)
    }
}

extension ChooseAvatarViewController: RegistroWorkerProtocol{
    func success() {
        DispatchQueue.main.async {
            self.hideLoader()
            InitRouter().goToInit(navigationController: self.navigationController)
        }
    }
    
    func fail(error: String) {
        DispatchQueue.main.async {
            self.hideLoader()
        }
    }
    
    
}
