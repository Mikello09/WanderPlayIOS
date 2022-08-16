//
//  FiltroFotoView.swift
//  Viajero
//
//  Created by Mikel Lopez on 13/01/2020.
//  Copyright © 2020 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit


protocol FiltroFotoDelegate{
    func onFiltroClicked(filtroName: String)
}

class FiltroFotoView: UICollectionViewCell{
    

    @IBOutlet var filtroImage: UIImageView!
    @IBOutlet var container: UIView!
    
    var delegate: FiltroFotoDelegate?
    var filtro: String = ""
    
    func configure(delegate: FiltroFotoDelegate, filtroName: String, originalImage: UIImage?, seleccionado: Bool){
        self.delegate = delegate
        self.filtro = filtroName
        container.circleShadow(color: seleccionado ? Colors.amarillo : UIColor.lightGray)
        
        guard let imageTaken = originalImage else {
            return
        }
        if filtroName != "Original" {
            filtroImage.applyFilter(filtroName: filtroName, imagen: imageTaken)
        } else{
            filtroImage.image = imageTaken
        }
        filtroImage.layoutIfNeeded()
        filtroImage.layer.cornerRadius = filtroImage.frame.height/2
        filtroImage.layer.masksToBounds = true
        
    }
    @IBAction func onCellClicked(_ sender: UIButton) {
        delegate?.onFiltroClicked(filtroName: filtro)
    }
    
}

extension UIImageView{
    
    func applyFilter(filtroName: String, imagen: UIImage){
        let ciContext = CIContext(options: nil)
        let coreImage = CIImage(image: imagen)
        let filter: CIFilter? = CIFilter(name: "\(filtroName)" )
        filter?.setDefaults()
        filter?.setValue(coreImage, forKey: kCIInputImageKey)
        let filteredImageData = filter?.value(forKey: kCIOutputImageKey) as! CIImage
        if let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent){
            self.image = UIImage(cgImage: filteredImageRef, scale: imagen.scale, orientation: imagen.imageOrientation)
        }
    }
    
}
