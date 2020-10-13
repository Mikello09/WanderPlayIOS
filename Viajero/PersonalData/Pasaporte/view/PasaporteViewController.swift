//
//  PasaporteViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 05/12/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


class PasaporteViewController: BaseViewController{
    
    @IBOutlet var topBar: TopBarOnlyBack!
    @IBOutlet var logrosView: UIView!
    @IBOutlet weak var gruposView: UIView!
    @IBOutlet weak var gruposCollectionView: UICollectionView!
    
    var presenter: PasaportePresenter?
    
    var allLogros: [GroupedLogros] = []
    var grupoActivo: String = "Lugares"
    var grupoLogroView: GrupoLogroView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar.setTitle(title: "Pasaporte")
        topBar.delegate = self
        
        grupoLogroView = GrupoLogroView().loadNib()
        grupoLogroView!.frame = CGRect(x: 0, y: 0, width: logrosView.frame.width, height: logrosView.frame.height)
        grupoLogroView!.setUpCollectionView()
        logrosView.addSubview(grupoLogroView!)
        
        self.logrosView.isHidden = true
        self.showLoader()
        presenter?.getUserLogros()
        
    }
}

extension PasaporteViewController: PasaportePresenterProtocol{
    func paintLogros(logros: [GroupedLogros]) {
        self.hideLoader()
        self.logrosView.isHidden = false
        self.allLogros = logros
        grupoLogroView!.configure(logros: logros[0].Logros)
        gruposCollectionView.reloadData()
    }
    
    func paintError() {
        self.hideLoader()
        self.navigationController?.popViewController(animated: false)
    }
    
    func groupChanged(logros: [Logro]){
        grupoLogroView!.configure(logros: logros)
        gruposCollectionView.reloadData()
    }
    
}

extension PasaporteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GrupoViewProtocol{
    func grupoSelected(grupo: String) {
        self.grupoActivo = grupo
        self.gruposCollectionView.reloadData()
        presenter?.groupChanged(grupo: grupo)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allLogros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "grupoCell", for: indexPath) as! GrupoView
        cell.configure(
            titulo: self.allLogros[indexPath.row].Grupo,
            showTriangle: self.allLogros[indexPath.row].Grupo == self.grupoActivo,
            delegate: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100 , height: 80)
    }
    
}

extension PasaporteViewController: TopBarOnlyBackProtocol{
    func atrasClicked() {
        self.navigationController?.popViewController(animated: false)
    }
    
    
}


