//
//  SceneDelegate.swift
//  FetchCodingChallenge
//
//  Created by Christian León Pérez Serapio on 18/09/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let rootVC = MealsViewController()
        let navController = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}

