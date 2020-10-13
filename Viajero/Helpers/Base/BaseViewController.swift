//
//  BaseViewController.swift
//  Viajero
//
//  Created by Mikel Lopez on 04/09/2019.
//  Copyright © 2019 Mikel Lopez. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController{
    
    var shadowView: UIView!
    
    override func viewDidLoad() {
        
        let tapView = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapView)
        
        if #available(iOS 13.0, *){
            overrideUserInterfaceStyle = .light
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc
    func dismissKeyboard(sender:UITapGestureRecognizer) {
        print("Dismiss keyboard")
        view.endEditing(true)
    }
    
    @objc
    func keyboardWillDisappear(notification: NSNotification){
        return
    }
    
    @objc
    func keyboardWillAppear(notification: NSNotification){
        return
    }
    
    func addBackItem(){
        
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "icon_back")?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(navBackButton(_:)), for: UIControl.Event.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        
        let currWidth = barButton.customView?.widthAnchor.constraint(equalToConstant: 28)
        currWidth?.isActive = true
        let currHeight = barButton.customView?.heightAnchor.constraint(equalToConstant: 28)
        currHeight?.isActive = true
        
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @IBAction func navBackButton(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    func paintNavigationBarWithBack(title: String){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = Colors.amarillo
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        self.navigationController?.navigationBar.topItem?.title = title
        
        let view = UIView(frame: UIApplication.shared.statusBarFrame)
        view.backgroundColor = Colors.amarillo
        self.view.addSubview(view)
        
        
        addBackItem()
    }
    
    func showLoader(){
        
            self.shadowView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: UIScreen.main.bounds.height))
            self.shadowView.backgroundColor = UIColor.white.withAlphaComponent(0.75)
            self.view.addSubview(self.shadowView)
           
            let rotateImage = UIImageView()
            rotateImage.translatesAutoresizingMaskIntoConstraints = false
            rotateImage.image = UIImage(named: "earth_icono")
            self.shadowView.addSubview(rotateImage)
            rotateImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
            rotateImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
            rotateImage.centerYAnchor.constraint(equalTo: self.shadowView.centerYAnchor).isActive = true
            rotateImage.centerXAnchor.constraint(equalTo: self.shadowView.centerXAnchor).isActive = true
            
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = 1
            rotationAnimation.repeatCount = Float.infinity
            
            rotateImage.layer.add(rotationAnimation, forKey: "rotationanimationkey")
            
            
            self.view.bringSubviewToFront(self.shadowView)
        
    }
    
    func hideLoader(){
        for view in self.view.subviews{
            if view == shadowView{
                view.removeFromSuperview()
            }
        }
        
    }
    
}
