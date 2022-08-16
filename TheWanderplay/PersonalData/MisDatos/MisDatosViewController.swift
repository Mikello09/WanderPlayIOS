//
//  MisDatosViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 09/10/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class MisDatosViewController: BaseViewController{
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var guardarButton: UIButton!
    @IBOutlet weak var topMessage: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var camposStack: UIStackView!
    
    var keyBoardIsShown: Bool = false
    var posicionEditando: Int = 0
    var progresoActual: Float = 0
    
    var presenter: MisDatosPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paintNavigationBarWithBack(title: "Mis Datos")
        
        setUpView()
    }
    
    override func navBackButton(_ sender: AnyObject) {
        if presenter?.infoUpdated ?? false{
//            AvisosRouter().goToAvisoStandard(
//                navigationController: self.navigationController,
//                mensaje: "Has realizado cambios en tus datos personales. Si no los guardas perderás los cambios."){
//                    self.popToPersonalData()
//           }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func popToPersonalData(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpView(){
        guardarButton.setNormalStyle()
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 7)
        presenter?.getCamposAMostrar()
    }
    
    @IBAction func guardarClicked(_ sender: UIButton) {
        
    }
    
    override func keyboardWillDisappear(notification: NSNotification){
        keyBoardIsShown = false
        self.view.frame.origin.y = 0
    }
    
    override func keyboardWillAppear(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if posicionEditando > 2 {
                if !keyBoardIsShown{
                    keyBoardIsShown = true
                    self.view.frame.origin.y -= keyboardSize.height//keyboardsize
                }
            } else {
                self.view.frame.origin.y = 0
            }
        }
    }
}

extension MisDatosViewController: MisDatosProtocol{
    func paintCampos(campos: [MisDatosModel]) {
        for campo in campos{
            let campoField: MisDatosFieldView = MisDatosFieldView()
            campoField.configure(posicion: campo.posicion, tipo: campo.tipo, texto: campo.valor, delegate: self)
            campoField.heightAnchor.constraint(equalToConstant: 100).isActive = true
            camposStack.addArrangedSubview(campoField)
        }
    }
    
    func updateProgreso(progreso: Float){
        self.progressBar.setProgress(progresoActual, animated: false)
        progresoActual = progreso
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.progressBar.setProgress(progreso, animated: false)
            UIView.animate(withDuration: 2, delay: 0, options: [], animations: { [unowned self] in
                self.progressBar.layoutIfNeeded()
            })
        }
        if progreso == 1{
            topMessage.text = "Perfecto!!Ahora guarda la información y recibe tu recompensa!!"
        } else {
            topMessage.text = "Completa todos tus datos y consigue nuevas recompensas"
        }
    }
}

extension MisDatosViewController: MisDatosFieldProtocol{
    func fieldEdited(posicion: Int, valor: String) {
        presenter?.updateFieldValue(posicion: posicion, valor: valor)
    }
    
    func fieldSelected(posicion: Int){
        self.posicionEditando = posicion
    }
    
}
