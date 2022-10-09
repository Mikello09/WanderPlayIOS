//
//  Extensions.swift
//  Viajero
//
//  Created by Mikel Lopez on 24/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    func removeShadow(){
        layer.masksToBounds = false
        layer.shadowOffset = CGSize.init(width: 0, height: 0)
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    func addShadowInContainerView(withRadius: CGFloat = 3, withBorder: Bool = true) {
        self.clipsToBounds = true
        self.layer.cornerRadius = withRadius
        if withBorder{
            self.layer.borderColor = UIColor.principal.cgColor
            self.layer.borderWidth = 0.1
        }
        self.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.2)
    }
    
    func addShadowForFilterView(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3
        //self.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 5.0, opacity: 0.2)
    }
    
    func circleShadow(color: UIColor){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderColor = color.cgColor
        self.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.2)
    }
    
}

extension UIButton {
    func shadowButton(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float){
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        //layer.shadowOpacity = opacity
    }
    
    func addShadowToButton() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 25
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.1
        self.shadowButton(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.2)
    }
    
    func setNormalStyle(){
        self.layer.cornerRadius = 3
        self.backgroundColor = Colors.azul
        self.tintColor = Colors.amarillo
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
}
