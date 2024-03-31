//
//  ServicesViewModel.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import UIKit
import Combine

final class ServicesViewModel: ServicesViewModelProtocol {
    
    var services = CurrentValueSubject<[Service], Never>([])
    var isNoInternet = PassthroughSubject<Bool, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getServices(from endpoint: Endpoint) {
        networkManager.fetchServicesResponseData(from: endpoint)
            .sink { [weak self] status in
                switch status {
                case .finished:
                    self?.isNoInternet.send(false)
                case .failure(_):
                    self?.isNoInternet.send(true)
                }
            } receiveValue: { [weak self] servicesResponseData in
                let servicesBody = ServicesBody(servicesBodyData: servicesResponseData.body)
                self?.services.value = servicesBody.services
            }
            .store(in: &subscriptions)
    }
    
    func getImage(from urlString: String) -> AnyPublisher<UIImage?, Error> {
        networkManager.fetchImage(from: urlString)
    }
}
