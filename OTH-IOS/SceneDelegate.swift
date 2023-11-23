//
//  SceneDelegate.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/22/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else {return}
        let window = UIWindow(windowScene: windowScene)
        
        let vc = MainViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        window.rootViewController = nav
        
        self.window = window
        self.window?.makeKeyAndVisible()
        
    }
}
