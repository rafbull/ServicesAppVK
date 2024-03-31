//
//  ServicesViewModelProtocol.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import UIKit
import Combine

protocol ServicesViewModelProtocol {
    var services: CurrentValueSubject<[Service], Never> { get }
    var isNoInternet: PassthroughSubject<Bool, Never> { get }
    
    func getServices(from endpoint: Endpoint)
    func getImage(from urlString: String) -> AnyPublisher<UIImage?, Error>
    
    init(networkManager: NetworkManagerProtocol)
}
