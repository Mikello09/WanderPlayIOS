//
//  OptionsViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 30/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

//extension MapaViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
//    
//    func openFiltros(){
//        filtrosView.isHidden ? showFiltros() : hideFiltros()
//        filtrosCollection.reloadData()
//    }
//    
//    func hideFiltros(){
//        self.filtrosView.alpha = 1.0
//        UIView.animate(withDuration: 1, animations: {
//            self.filtrosView.alpha = 0.0
//            self.filtrosView.isHidden = true
//        })
//    }
//    
//    func showFiltros(){
//        self.filtrosView.alpha = 0.0
//        UIView.animate(withDuration: 1, animations: {
//            self.filtrosView.alpha = 1.0
//            self.filtrosView.isHidden = false
//        })
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return filtrosList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filtrosCategoriaCell", for: indexPath) as! FiltrosCollectionCell
//        cell.configure(filtro: filtrosList[indexPath.row], delegate: self)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout
//        collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100 , height: 100)
//    }
//    
//}
//
//extension MapaViewController: FiltrosCategoriaCellProtocol, MapaPresenterFiltrosProtocol{
//    func filtrosFilled(lista: [FiltroCategoriaModel]) {
//        filtrosList = lista
//    }
//    
//    func filtroSelected(posicion: Int) {
//        filtrosList[posicion].seleccionado = true
//        filtrosCollection.reloadData()
//        FiltrosManager.shared.setFiltros(categoriaFiltros: getSelectedFilters(filtros: filtrosList), tipoLugaresFiltros: FiltrosManager.shared.tipoLugaresFiltros)
//        self.interactor?.getLugares()
//        rightMenu.updateNumberFiltros(filtros: filtrosQuantity(filtros: filtrosList))
//    }
//    
//    func filtroDeselected(posicion: Int) {
//        filtrosList[posicion].seleccionado = false
//        filtrosCollection.reloadData()
//        FiltrosManager.shared.setFiltros(categoriaFiltros: getSelectedFilters(filtros: filtrosList), tipoLugaresFiltros: FiltrosManager.shared.tipoLugaresFiltros)
//        self.interactor?.getLugares()
//        rightMenu.updateNumberFiltros(filtros: filtrosQuantity(filtros: filtrosList))
//    }
//    
//    func filtrosQuantity(filtros: [FiltroCategoriaModel]) -> Int{
//        var counter = 0
//        filtros.forEach({if $0.seleccionado {counter += 1}})
//        return counter
//    }
//    
//    func getSelectedFilters(filtros: [FiltroCategoriaModel]) -> [FiltroCategoriaModel]{
//        return filtros.filter({$0.seleccionado})
//    }
//    
//    
//}
