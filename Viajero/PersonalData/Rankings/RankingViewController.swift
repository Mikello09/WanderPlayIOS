//
//  RankingViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 28/01/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


class RankingViewController: BaseViewController{
    
    @IBOutlet var topBar: TopBarOnlyBack!
    @IBOutlet var tabla: UITableView!
    @IBOutlet var emptyView: UIView!
    
    var presenter: RankingPresenter?
    
    var usuarios: [UsuarioModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBar.setTitle(title: "Ranking")
        topBar.delegate = self
        
        self.showLoader()
        presenter?.getRankings()
        
    }
    
    @IBAction func tabChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            presenter?.getRankings()
        } else {
            paintEmpty()
        }
    }
}

extension RankingViewController: RankingPresenterProtocol{
    func paintRankings(usuarios: [UsuarioModel]) {
        self.hideLoader()
        emptyView.isHidden = true
        tabla.isHidden = false
        self.usuarios = usuarios
        tabla.reloadData()
        var scrollToPosition = 0
        for (i,user) in usuarios.enumerated(){
            if user.nombre == Usuario.shared.nombre{
                scrollToPosition = i
            }
        }
        tabla.scrollToRow(at: IndexPath(row: scrollToPosition, section: 0), at: .middle, animated: true)
    }
    
    func paintEmpty() {
        self.hideLoader()
        emptyView.isHidden = false
        tabla.isHidden = true
    }
}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingCell") as! RankingCell
        cell.configure(posicion: indexPath.row + 1,
                       imagen: "",
                       nombre: usuarios[indexPath.row].nombre ?? "",
                       lugares: usuarios[indexPath.row].lugares ?? [],
                       nivel: usuarios[indexPath.row].getNivel(),
                       avatar: usuarios[indexPath.row].avatarActivo ?? "")
        return cell
    }
}


extension RankingViewController: TopBarOnlyBackProtocol{
    func atrasClicked() {
        self.navigationController?.popViewController(animated: false)
    }
    
    
}
