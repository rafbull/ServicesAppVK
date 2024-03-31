//
//  ServicesCoordinator.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import UIKit

final class ServicesCoordinator: Coordinator {
    
    var rootNavigationController: UINavigationController
    
    private let servicesViewModel: ServicesViewModelProtocol
    
    init(
        navigationController: UINavigationController = UINavigationController(),
        servicesViewModel: ServicesViewModelProtocol = ServicesViewModel()
    ) {
        self.rootNavigationController = navigationController
        self.servicesViewModel = servicesViewModel
    }
    
    func start() {
        let servicesViewController = ServicesViewController(viewModel: servicesViewModel)
        rootNavigationController.setViewControllers([servicesViewController], animated: false)
    }
}

