//
//  PersonalDataViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 08/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import Lottie
import SceneKit
import SpriteKit

class PersonalDataViewController: BaseViewController{
    
 
    
    @IBOutlet weak var irAMapaButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var nombreLabel: UILabel!
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var camerinosButton: UIButton!
    
    @IBOutlet weak var avatarImageContainer: UIView!
    @IBOutlet weak var avatarValueLabel: UILabel!
    @IBOutlet weak var monedaImageContainer: UIView!
    @IBOutlet weak var monedasValueLabel: UILabel!
    @IBOutlet weak var diamantesImageContainer: UIView!
    @IBOutlet weak var diamantesValueLabel: UILabel!
    @IBOutlet weak var lugaresImageContainer: UIView!
    @IBOutlet weak var lugaresValueLabel: UILabel!
    @IBOutlet weak var nivelLabel: UILabel!
    var presenter: PersonalDataPresenter?
    var items: [PersonalDataCollectionItem] = []
    var dayMoment: DayMoment = .dia
    
    //let columnLayout = ColumnFlowLayout(cellsPerRow: 3, minimumInteritemSpacing: 15, minimumLineSpacing: 6, sectionInset: UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15), cellHeight: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let bigAvatar: SCNScene = SCNScene(named: Usuario.shared.getAvatarActivoWalking())!
        sceneView.present(bigAvatar, with: .fade(withDuration: 0.05), incomingPointOfView: nil)
        sceneView.loops = true
        sceneView.isPlaying = true
        
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = .omni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 300, 200)
        bigAvatar.rootNode.addChildNode(omniLightNode)
        
        setBackgroundImage()
        
        
        setInitialValues()
        presenter?.getItems()
        
    }
    
    func setInitialValues() {
        
        nombreLabel.text = Usuario.shared.nombre
        nivelLabel.text = "Nvl \(Usuario.shared.nivel)"
        avatarImageContainer.addShadowInContainerView()
        avatarValueLabel.text = Usuario.shared.avatarActivo
        monedaImageContainer.addShadowInContainerView()
        monedasValueLabel.text = "\(Usuario.shared.monedas)"
        diamantesImageContainer.addShadowInContainerView()
        diamantesValueLabel.text = "\(Usuario.shared.diamantes)"
        lugaresImageContainer.addShadowInContainerView()
        lugaresValueLabel.text = "\(Usuario.shared.lugares.count)"
        
        irAMapaButton.addShadowInContainerView()
        camerinosButton.addShadowInContainerView()
        
    }
    
    
    @IBAction func onVolverAlMapa(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func camerinosClicked(_ sender: UIButton) {
        CamerinosRouter().goToCamerinos(navigationController: self.navigationController)
    }
}

extension PersonalDataViewController: PersonalDataProtocol{
    func setItems(items: [PersonalDataCollectionItem]){
        self.items = items
        collectionView.reloadData()
    }
    
    func setBackgroundImage(){
        switch Usuario.shared.avatarActivo {
            case "Inspector":
                backgroundImage.image = UIImage(named: "mistery_background")
                nombreLabel.textColor = .white
                nivelLabel.textColor = .white
                avatarValueLabel.textColor = .white
                monedasValueLabel.textColor = .white
                diamantesValueLabel.textColor = .white
                lugaresValueLabel.textColor = .white
            case "Militar":
                backgroundImage.image = UIImage(named: "military_background")
                nombreLabel.textColor = .white
                nivelLabel.textColor = .white
                avatarValueLabel.textColor = .white
                monedasValueLabel.textColor = .white
                diamantesValueLabel.textColor = .white
                lugaresValueLabel.textColor = .white
            case "Playero":
                backgroundImage.image = UIImage(named: "playa_fondo")
                nombreLabel.textColor = .white
                nivelLabel.textColor = .white
                avatarValueLabel.textColor = .white
                monedasValueLabel.textColor = .white
                diamantesValueLabel.textColor = .white
                lugaresValueLabel.textColor = .white
            case "Enfermero":
                backgroundImage.image = UIImage(named: "fondo_surgery")
                nombreLabel.textColor = .white
                nivelLabel.textColor = .white
                avatarValueLabel.textColor = .white
                monedasValueLabel.textColor = .white
                diamantesValueLabel.textColor = .white
                lugaresValueLabel.textColor = .white
            case "Futoblista":
                backgroundImage.image = UIImage(named: "football_fondo")
                nombreLabel.textColor = .white
                nivelLabel.textColor = .white
                avatarValueLabel.textColor = .white
                monedasValueLabel.textColor = .white
                diamantesValueLabel.textColor = .white
                lugaresValueLabel.textColor = .white
            default:
                return
        }
    }
}

extension PersonalDataViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personalDataCell", for: indexPath) as! PersonalDataCollectionCell
        cell.configure(item: self.items[indexPath.row], from: self, dayMoment: dayMoment)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 48)/3, height: (self.collectionView.frame.height - 36)/3)
    }
    
}
