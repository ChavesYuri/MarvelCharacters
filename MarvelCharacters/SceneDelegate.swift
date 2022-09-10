//
//  SceneDelegate.swift
//  MarvelCharacters
//
//  Created by Yuri Chaves on 09/09/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupRootController(windowScene: windowScene)
    }

    private func setupRootController(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        let rootViewController = CharactersListViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)

        window.rootViewController = navigationController

        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

