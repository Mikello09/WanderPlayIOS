//
//  MapaPresenter.swift
//  Viajero
//
//  Created by Mikel Lopez on 10/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation


protocol MapaPresenterFiltrosProtocol{
    func filtrosFilled(lista: [FiltroCategoriaModel])
}


class MapaPresenter{
    
    var mapaFiltrosDelegate: MapaPresenterFiltrosProtocol?
    var modoSinConexion: Bool?
    
   
    func fillFiltros(){
        Categorias.shared.rellenarCategorias()
        var categorias: [FiltroCategoriaModel] = []
        for (i,_) in Categorias.shared.categorias.enumerated(){
            let filtro: FiltroCategoriaModel = FiltroCategoriaModel(titulo: Categorias.shared.titulos[i],
                                                                    imagen: Categorias.shared.imagenes[i],
                                                                    seleccionado: false,
                                                                    posicion: i)
            categorias.append(filtro)
        }
        mapaFiltrosDelegate?.filtrosFilled(lista: categorias)
    }
    
}
