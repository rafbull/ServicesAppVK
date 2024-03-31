//
//  NetworkManager.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import UIKit
import Combine


protocol NetworkManagerProtocol {
    func fetchServicesResponseData(from endpoint: Endpoint) -> AnyPublisher<ServicesResponseData, Error>
    func fetchImage(from urlString: String) -> AnyPublisher<UIImage?, Error>
}


final class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Private Properties
    private let session = URLSession.shared
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Methods
    func fetchServicesResponseData(from endpoint: Endpoint) -> AnyPublisher<ServicesResponseData, Error> {
        fetchServices(from: endpoint).eraseToAnyPublisher()
    }
    
    func fetchImage(from urlString: String) -> AnyPublisher<UIImage?, Error> {
        guard let url = URL(string: urlString) else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        
        if let cachedImage = cachedImages.object(forKey: url as NSURL) {
            return Just(cachedImage)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode)
                else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .map { [weak self] data in
                guard let image = UIImage(data: data) else { return nil }
                self?.cachedImages.setObject(image, forKey:  url as NSURL)
                return image
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: Private Methods
    private func fetchServices<T: Decodable>(from endpoint: Endpoint) -> AnyPublisher<T, Error> {
        let urlString = endpoint.absoluteURL()
        
        guard let url = URL(string: urlString) else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode)
                else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}


