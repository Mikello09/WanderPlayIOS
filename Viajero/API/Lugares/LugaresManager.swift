//
//  LugaresManager.swift
//  Viajero
//
//  Created by Mikel Lopez on 10/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import MapKit
//import ObjectMapper


protocol LugaresManagerProtocol {
    func lugaresUpdated(lugares: [Lugar]?)
    func failGettingLugares()
}

class LugaresManager{
    
    private var lugaresJson: JSONDictionary?
    var invalidate: Bool = true
    static var shared = LugaresManager()
    var delegate: LugaresManagerProtocol?
    var mustApplyFilters: Bool = true
    
    
    func getLugares(delegate: LugaresManagerProtocol){
        self.delegate = delegate
        if FiltrosManager.shared.isFiltrosToApply() && mustApplyFilters{
            applyFilters(filtersCategoria: FiltrosManager.shared.categoriaFiltros, tipoLugares: FiltrosManager.shared.tipoLugaresFiltros)
        } else {
            mustApplyFilters = true
            self.delegate?.lugaresUpdated(lugares: Lugares.shared.getLugares())
        }
    }
    
    func getFilteredLugares(delegate: LugaresManagerProtocol,filtersCategoria: [FiltroCategoriaModel], tipoLugaresFiltros: [TipoLugar]){
        self.delegate = delegate
        applyFilters(filtersCategoria: filtersCategoria, tipoLugares: tipoLugaresFiltros)
    }
    
    
    func invalidateLugares(){
        self.invalidate = true
    }
    
    func applyFilters(filtersCategoria: [FiltroCategoriaModel], tipoLugares: [TipoLugar]){
        var lugaresFiltrados: [Lugar] = []
        
        for lugar in Lugares.shared.getLugares(){
            if filtersCategoria.count > 0 {
                for categoria in filtersCategoria where categoria.titulo == lugar.categoria{
                    
                    if tipoLugares.contains(lugar.getTipoLugar()){
                        lugaresFiltrados.append(lugar)
                    }
                    
                    continue
                }
            } else {
                if tipoLugares.count > 0 && tipoLugares.count < 5 {
                    if tipoLugares.contains(lugar.getTipoLugar()){ lugaresFiltrados.append(lugar)}
                }
            }
        }
        
        delegate?.lugaresUpdated(lugares: lugaresFiltrados)
    }
    
    func isLugarVisited(lugarId: String) -> Bool{
        
        var encontrado = false
        //Usuario.shared.lugares_visitados.forEach({if $0.id == lugarId {encontrado = true}})
        return encontrado
        
    }
    
    func getLugarFromId(lugarId: String) -> Lugar?{
        return Lugares.shared.getLugares().filter{$0._id == lugarId}.first
    }
    
}


