//
//  GrupoLogroView.swift
//  Viajero
//
//  Created by Mikel Lopez on 05/12/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class GrupoLogroView: UIView{
    

    @IBOutlet var collectionView: UICollectionView!
    
    var logrosUsuario: [Logro] = []
    
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let columnLayout = ColumnFlowLayout(cellsPerRow: 3, minimumInteritemSpacing: 8, minimumLineSpacing: 8, sectionInset: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16), cellHeight: UIScreen.main.bounds.width/3 - 32 - CGFloat(2*8))
        
        collectionView.collectionViewLayout = columnLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(UINib.init(nibName: "TrophyView", bundle: nil), forCellWithReuseIdentifier: "TrophyView")
        collectionView.register(UINib.init(nibName: "NoTrophyView", bundle: nil), forCellWithReuseIdentifier: "NoTrophyView")
    }
    
    func configure(logros: [Logro]){
        self.logrosUsuario = logros
        collectionView.reloadData()
    }
    
    func isLogrado(logroToCompare: Logro) -> Bool{
        return logroToCompare.porcentaje ?? 0 >= 100
    }
    
}

extension GrupoLogroView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return logrosUsuario.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let logro = logrosUsuario[indexPath.row]
        if isLogrado(logroToCompare: logro){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrophyView", for: indexPath) as! TrophyView
            cell.titulo.text = logro.titulo
            cell.imagen.image = UIImage(named: "trophy1")//logro.imagen
            cell.configure()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoTrophyView", for: indexPath) as! NoTrophyView
            cell.configure(mensaje: logrosUsuario[indexPath.row].descripcion ?? "",
                           porcentaje: logrosUsuario[indexPath.row].porcentaje ?? 0,
                           monedas: logrosUsuario[indexPath.row].monedas ?? 0,
                           diamantes: logrosUsuario[indexPath.row].diamantes ?? 0)
            return cell
        }
    }
    
}

extension GrupoLogroView{
    func loadNib() -> GrupoLogroView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! GrupoLogroView
    }
}
