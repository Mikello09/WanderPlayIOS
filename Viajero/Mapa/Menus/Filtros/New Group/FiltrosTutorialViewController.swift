//
//  FiltrosTutorial.swift
//  Viajero
//
//  Created by Mikel Lopez on 17/05/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class FiltrosTutorialViewController: UIViewController{
    
    @IBOutlet weak var topBar: TopBarOnlyBack!
    @IBOutlet weak var profesorContainer: UIView!
    
    var profesorView: ProfesorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    func setView(){
        topBar.titulo.text = ""
        topBar.delegate = self
        
        profesorView = ProfesorView(frame: profesorContainer.frame)
        profesorView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        profesorView?.configure()
        profesorView?.setUpFiltrosTutorial()
        profesorContainer.addSubview(profesorView!)
    }
    
}

extension ProfesorView: FiltroTutorialViewProtocol{
    
    func setUpFiltrosTutorial(){
        setScene(profesor: .habla)
        
        filtroTutorialView = FiltroTutorialView(frame: self.bocadilloView.frame)
        filtroTutorialView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bocadilloView.addSubview(filtroTutorialView!)
        filtroTutorialView!.configure(texto: ["Esta es la barra de filtros. Aquí podrás filtrar los lugares según su importancia y categoría.", "Al pulsar en cada pin se activará/desactivará el filtro mostrando más o menos lugares en el mapa.", "A continuación te muestro el resumen de cada color."], delegate: self)
    }
    
    func filtroTutorialtextHasFinished() {
        filtroTutorialView!.showPinesResumen()
    }
    
}

extension FiltrosTutorialViewController: TopBarOnlyBackProtocol{
    func atrasClicked() {
        self.dismiss(animated: false, completion: nil)
    }
    
    
}
