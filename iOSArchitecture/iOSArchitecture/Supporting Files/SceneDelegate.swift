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
            let searchRequest = MusicSearchRequest()
            let musicNetworkManager = MusicNetworkManager()
            let musicSearchRepository = MusicSearchRepository(musicSearchRequest: searchRequest, musicNetworkManager: musicNetworkManager)
            let searchViewModel = SearchSongViewModel(musicSearchRepository: musicSearchRepository)
            let searchViewController = SearchViewController(viewModel: searchViewModel)
            let navigationController = UINavigationController(rootViewController: searchViewController)
            navigationController.navigationBar.prefersLargeTitles = true
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}

