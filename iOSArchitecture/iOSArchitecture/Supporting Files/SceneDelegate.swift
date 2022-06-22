//
//  SceneDelegate.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        if let window = window {
            let searchViewController = SearchViewController()
            let navigationController = UINavigationController(rootViewController: searchViewController)
            navigationController.navigationBar.prefersLargeTitles = true
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}

