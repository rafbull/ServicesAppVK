//
//  Endpoint.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import Foundation

enum Endpoint {
    case services
    
    func absoluteURL() -> String {
        baseURL + path()
    }
    
    private var baseURL: String {
        "https://publicstorage.hb.bizmrg.com/sirius/result.json"
    }
    
    private func path() -> String {
        switch self {
        case .services:
            return ""
        }
    }
}
