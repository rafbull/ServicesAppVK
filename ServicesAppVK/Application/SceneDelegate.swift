//
//  SceneDelegate.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let appCoordinator = AppCoordinator(window: window)
        
        appCoordinator.start()
        
        self.appCoordinator = appCoordinator
        window.makeKeyAndVisible()
    }
}
