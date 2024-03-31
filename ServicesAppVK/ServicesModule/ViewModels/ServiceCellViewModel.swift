//
//  ServiceCellViewModel.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import Foundation
import Combine
import UIKit

final class ServiceCellViewModel: ServiceCellViewModelProtocol {
    
    let serviceIconImage = CurrentValueSubject<UIImage?, Never>(nil)
    let serviceName = CurrentValueSubject<String, Never>("")
    let serviceDescription = CurrentValueSubject<String, Never>("")
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let service: Service
    
    init(service: Service, serviceIconImage: AnyPublisher<UIImage?, Error>?) {
        self.service = service
        setupPublisher(serviceIconImage)
    }
    
    private func setupPublisher(_ serviceIconImage: AnyPublisher<UIImage?, Error>?) {
        serviceName.send(service.name)
        serviceDescription.send(service.description)
        
        guard let serviceIconImage = serviceIconImage else { return }
        serviceIconImage.sink { status in
            switch status {
            case .finished:
                break
            case .failure(_):
                break
            }
        } receiveValue: { [weak self] image in
            self?.serviceIconImage.send(image)
        }
        .store(in: &subscriptions)
    }
}
