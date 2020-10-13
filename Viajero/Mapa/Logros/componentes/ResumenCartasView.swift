//
//  ResumenCartasView.swift
//  Viajero
//
//  Created by Mikel Lopez on 19/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol ResumenCartasProtocol{
    func okClicked()
}

class ResumenCartasView: UIView{
    
    @IBOutlet weak var resumenCollection: UICollectionView!
    @IBOutlet var view: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var container: UIView!
    
    var delegate: ResumenCartasProtocol?
    var logros: [Logro] = []
    
    
    let columnLayout = ColumnFlowLayout(cellsPerRow: 2, minimumInteritemSpacing: 15, minimumLineSpacing: 6, sectionInset: UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15), cellHeight: 150)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("ResumenCartasView", owner: self, options: nil)
        view.frame = bounds
        self.addSubview(self.view)
    }
    
    func configure(delegate: ResumenCartasProtocol, logros: [Logro]){
        self.delegate = delegate
        self.logros = logros
        okButton.addShadowInContainerView()
        
        resumenCollection.delegate = self
        resumenCollection.dataSource = self
        resumenCollection.collectionViewLayout = columnLayout
        resumenCollection.contentInsetAdjustmentBehavior = .always
        resumenCollection.register(UINib.init(nibName: "ResumenCartasCell", bundle: nil), forCellWithReuseIdentifier: "ResumenCartasCell")
        resumenCollection.backgroundColor = UIColor.clear
    }
    
    @IBAction func okClicked(_ sender: UIButton) {
        delegate?.okClicked()
    }
}

extension ResumenCartasView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return logros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResumenCartasCell", for: indexPath) as! ResumenCartasCell
        cell.configure(titulo: logros[indexPath.row].titulo ?? "",
                       monedas: "\(logros[indexPath.row].monedas ?? 0)",
                       diamantes: "\(logros[indexPath.row].diamantes ?? 0)",
                       imagen: "")
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
