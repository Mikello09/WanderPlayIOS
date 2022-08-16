//
//  MostrarCartasView.swift
//  Viajero
//
//  Created by Mikel Lopez on 15/11/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit
import Lottie

protocol MostrarCartasViewProtocol{
    func finished()
}

class MostrarCartasView: UIView{
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var cardContainer: CardView!
    @IBOutlet var animationUnboxing: AnimationView!
    
    
    var i = 0
    var logros:[Logro] = []
    var delegate: MostrarCartasViewProtocol?
    var dimensions: CGSize?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("MostrarCartasView", owner: self, options: nil)
        view.frame = bounds
        self.addSubview(self.view)
    }
    
    func start(logros: [Logro], delegate: MostrarCartasViewProtocol, dimensions: CGSize){
        self.delegate = delegate
        self.dimensions = dimensions
        self.logros = logros
        self.cardContainer.isHidden = true
        animationUnboxing.animation = Animation.named("unboxing")
        animationUnboxing.loopMode = .playOnce
        animationUnboxing.play()
        
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.cardContainer.isHidden = false
            self.addCard(i: self.i)
        }
    }
    
    func addCard(i: Int){
        let cardView = CardView(frame: CGRect(x: 0, y: 0, width: cardContainer.frame.width, height: cardContainer.frame.height))
        cardView.configure(titulo: logros[i].descripcion ?? "", monedas: "\(logros[i].monedas ?? 0)",diamantes: "\(logros[i].diamantes ?? 0)", imagen: "")
        cardView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cardView.translatesAutoresizingMaskIntoConstraints = true
        for cv in cardContainer.subviews{
            cv.removeFromSuperview()
        }
        self.cardContainer.addSubview(cardView)
        
        let path = UIBezierPath()
        
        if let dimensiones = dimensions{
            let startPoint: CGPoint = CGPoint(x: (dimensiones.width/2)-50, y: dimensiones.height - 162)
            let endPoint: CGPoint = CGPoint(x: (dimensiones.width/2)-25, y: 87)
            let controlPotin: CGPoint = CGPoint(x: (dimensiones.width/4), y: (dimensiones.height/2))
            
            path.move(to: startPoint)
            path.addQuadCurve(to: endPoint, controlPoint: controlPotin)
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.i += 1
                let seconds = 2.0
                if self.i < self.logros.count{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.cardContainer.isHidden = true
                        self.animationUnboxing.play()
                        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                            self.cardContainer.isHidden = false
                            self.addCard(i: self.i)
                        }
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                        self.delegate?.finished()
                    }
                }
            })
            
            let animation = CAKeyframeAnimation(keyPath: "position")
            animation.path = path.cgPath
            animation.repeatCount = 0
            animation.duration = 2.0
            self.cardContainer.layer.add(animation, forKey: "animate along path")
           
            
            CATransaction.commit()
            
        }
        
    }
}
