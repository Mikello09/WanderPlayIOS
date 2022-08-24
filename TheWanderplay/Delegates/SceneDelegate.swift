//
//  SceneDelegate.swift
//  TheWanderplay
//
//  Created by Mikel Lopez Salazar on 24/8/22.
//  Copyright © 2022 Mikel Lopez. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        if let _ = Usuario.shared.getNombreCredencial(){
            let window = UIWindow(windowScene: windowScene)
            let storyboard = UIStoryboard(name: "Init", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "navBarInit")
            window.rootViewController = initialViewController
            self.window = window
            window.makeKeyAndVisible()
        } else {
            let window = UIWindow(windowScene: windowScene)
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "navBarLogin")
            window.rootViewController = initialViewController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
