//
//  AppCoordinator.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    
    private var childCoordinators = [Coordinator]()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let mainCoordinator = ServicesCoordinator()
        mainCoordinator.start()
        childCoordinators = [mainCoordinator]
        window.rootViewController = mainCoordinator.rootNavigationController
    }
}

