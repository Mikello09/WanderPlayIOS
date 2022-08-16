//
//  RankingPresenter.swift
//  Viajero
//
//  Created by Mikel Lopez on 01/02/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

protocol RankingPresenterProtocol{
    func paintRankings(usuarios: [UsuarioModel])
    func paintEmpty()
}

class RankingPresenter{
    
    var delegate: RankingPresenterProtocol?
    
    func getRankings(){
        RankingWorker().getGeneralRanking(delegate: self)
    }
    
}

extension RankingPresenter: RankingProtocol{
    
    func generalRanking(usuarios: [UsuarioModel]){
        delegate?.paintRankings(usuarios: usuarios.sorted(by: {$0.puntos ?? 0 > $1.puntos ?? 0}))
    }
    
    func failGeneralRanking(){
        delegate?.paintEmpty()
    }
    
}
