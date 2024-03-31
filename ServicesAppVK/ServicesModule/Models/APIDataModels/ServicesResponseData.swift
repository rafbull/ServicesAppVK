//
//  ServicesResponseData.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import Foundation

struct ServicesResponseData: Decodable {
    let body: ServicesBodyData
    let status: Int
}

struct ServicesBodyData: Decodable {
    let services: [ServiceData]
}

struct ServiceData: Decodable {
    let name: String
    let description: String
    let link: String
    let iconUrl: String
}
