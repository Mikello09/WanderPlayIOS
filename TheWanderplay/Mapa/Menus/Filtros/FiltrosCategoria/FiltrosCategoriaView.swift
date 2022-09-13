//
//  FiltrosCategoriaView.swift
//  TheWanderplay
//
//  Created by Mikel Lopez Salazar on 5/9/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol FiltrosCategoriaViewProtocol {
    func categoriaSelected(categorias: [Categoria])
}

class FiltrosCategoriaView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var categoriasTable: UITableView!
    
    var delegate: FiltrosCategoriaViewProtocol?
    
    var categorias: [Categoria] = CategoriasManager.shared.categorias
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("FiltrosCategoriaView", owner: self, options: nil)
        view.frame = bounds
        self.addSubview(self.view)
    }
    
    func configure(delegate: FiltrosCategoriaViewProtocol) {
        self.delegate = delegate
        // Container
        container.layer.cornerRadius = 8
        container.addShadowInContainerView(withRadius: 8)
        // TABLA
        categoriasTable.delegate = self
        categoriasTable.dataSource = self
        categoriasTable.register(UINib(nibName: "CategoriaCell", bundle: nil), forCellReuseIdentifier: "categoriaCell")
    }
    
}

// MARK: TABLE VIEW
extension FiltrosCategoriaView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoriaCell") as? CategoriaCell else { return UITableViewCell() }
        cell.configure(categoria: categorias[indexPath.row], isAcvite: CategoriasManager.shared.isCategoriaActive(categoria: categorias[indexPath.row]), delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}

// MARK: CATEGORIA CELL
extension FiltrosCategoriaView: CategoriaCellProtocol {
    func categoriaSelected(categoria: Categoria) {
        CategoriasManager.shared.categoriaSelected(categoria: categoria)
        categoriasTable.reloadData()
        delegate?.categoriaSelected(categorias: CategoriasManager.shared.activeCategorias)
    }
}
