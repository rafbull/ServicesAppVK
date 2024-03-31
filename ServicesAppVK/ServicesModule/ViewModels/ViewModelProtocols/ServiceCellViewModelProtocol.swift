//
//  ServiceCellViewModelProtocol.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//


import UIKit
import Combine

protocol ServiceCellViewModelProtocol {
    var serviceIconImage: CurrentValueSubject<UIImage?, Never> { get }
    var serviceName: CurrentValueSubject<String, Never> { get }
    var serviceDescription: CurrentValueSubject<String, Never> { get }
    
    init(service: Service, serviceIconImage: AnyPublisher<UIImage?, Error>?)
}
