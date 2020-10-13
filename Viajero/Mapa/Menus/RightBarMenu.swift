//
//  RightBarMenu.swift
//  Viajero
//
//  Created by Mikel Lopez on 10/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import Lottie


protocol RightBarMenuProtocol{
    func updateTipoLugares(tipoFiltros: [TipoLugar])
    func filterClicked()
}

class RightBarMenu: UIView{
    @IBOutlet var filterContainer: UIView!
    @IBOutlet var view: UIView!
    @IBOutlet var filtrosView: UIView!
    @IBOutlet var numberView: UIView!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var container: UIView!
    
    @IBOutlet var rojoImage: UIImageView!
    @IBOutlet var naranjaImage: UIImageView!
    @IBOutlet var amarilloImage: UIImageView!
    @IBOutlet var azulImage: UIImageView!
    @IBOutlet var verdeImage: UIImageView!
    
    @IBOutlet var containerRojo: UIView!
    @IBOutlet var containerNaranja: UIView!
    @IBOutlet var containerAmarillo: UIView!
    @IBOutlet var containerAzul: UIView!
    @IBOutlet var containerVerde: UIView!
    
    @IBOutlet var arrowCategoriasImage: UIImageView!
    var fromViewController: UIViewController!
    var delegate: RightBarMenuProtocol?
    
    let arrowDown: UIImage = UIImage(systemName: "arrow.down.circle.fill")!
    let arrowUp: UIImage = UIImage(systemName: "arrow.up.circle.fill")!
    var categoriasShowed: Bool = false
    
    var filtrosPin: [TipoLugar] = [.bajo, .medio, .alto, .muyAlto, .patrimonio]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("RightBarMenu", owner: self, options: nil)
        view.frame = bounds
        self.addSubview(self.view)
    }
    
    func configure(delegate: RightBarMenuProtocol, from: UIViewController){
        self.delegate = delegate
        self.fromViewController = from
        
        arrowCategoriasImage.image = arrowDown
    
        filterContainer.addShadowInContainerView()
        let tapView = UITapGestureRecognizer(target: self, action: #selector(filterClicked))
        self.filterContainer.isUserInteractionEnabled = true
        self.filterContainer.addGestureRecognizer(tapView)
        
        container.addShadowInContainerView(withRadius: 8)
        containerRojo.addShadowInContainerView()
        containerNaranja.addShadowInContainerView()
        containerAmarillo.addShadowInContainerView()
        containerAzul.addShadowInContainerView()
        containerVerde.addShadowInContainerView()
        
        containerRojo.removeShadow()
        containerNaranja.removeShadow()
        containerAmarillo.removeShadow()
        containerAzul.removeShadow()
        containerVerde.removeShadow()
        
        
    }
    
    func updateNumberFiltros(filtros: Int){
        if filtros > 0{
            numberView.isHidden = false
            numberLabel.text = "\(filtros)"
        } else {
            numberView.isHidden = true
        }
    }
    
    @objc func filterClicked(){
        categoriasShowed ? setDownArrowImage() : setUpArrowImage()
        delegate?.filterClicked()
        categoriasShowed.toggle()
    }
    
    func setUpArrowImage(){
        arrowCategoriasImage.image = arrowUp
    }
    
    func setDownArrowImage(){
        arrowCategoriasImage.image = arrowDown
    }
    
    @IBAction func rojoPinClicked(_ sender: UIButton) {
        updateFiltrosPin(tipo: .patrimonio, image: rojoImage, contenedor: containerRojo)
    }
    
    @IBAction func naranjaPinClicked(_ sender: UIButton) {
        updateFiltrosPin(tipo: .muyAlto, image: naranjaImage, contenedor: containerNaranja)
    }
    
    @IBAction func amarilloPinClicked(_ sender: UIButton) {
        updateFiltrosPin(tipo: .alto, image: amarilloImage, contenedor: containerAmarillo)
    }
    
    @IBAction func azulPinClicked(_ sender: UIButton) {
        updateFiltrosPin(tipo: .medio, image: azulImage, contenedor: containerAzul)
    }
    
    @IBAction func verdePinClicked(_ sender: UIButton) {
        updateFiltrosPin(tipo: .bajo, image: verdeImage, contenedor: containerVerde)
    }
    
    func updateFiltrosPin(tipo: TipoLugar, image: UIImageView, contenedor: UIView){
        if filtrosPin.contains(tipo){
            if filtrosPin.count != 1{//para que siempre haya como minimo un pin con color
                var nuevosFiltros: [TipoLugar] = []
                for filtro in filtrosPin where filtro != tipo{
                    nuevosFiltros.append(filtro)
                }
                filtrosPin = nuevosFiltros
                image.image = UIImage(named: "pin_gris_image")
                contenedor.addShadowInContainerView()
            }
        } else {
            filtrosPin.append(tipo)
            image.image = UIImage(named: tipo.getImage())
            contenedor.removeShadow()
        }
        delegate?.updateTipoLugares(tipoFiltros: filtrosPin)
    }
    
    @IBAction func helpClicked(_ sender: UIButton) {
        FiltrosTutorialRouter().goToFiltrosTutorial(navigationController: self.fromViewController.navigationController)
    }
}
