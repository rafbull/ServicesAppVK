//
//  Services.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import Foundation

struct ServicesBody: Hashable {
    let services: [Service]
    
    init(servicesBodyData: ServicesBodyData) {
        self.services = servicesBodyData.services.map { Service(serviceData: $0) }
    }
}

struct Service: Hashable {
    let name: String
    let description: String
    let link: String
    let iconURL: String
    
    init(serviceData: ServiceData) {
        name = serviceData.name
        description = serviceData.description
        link = serviceData.link
        iconURL = serviceData.iconUrl
    }
}
