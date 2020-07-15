//
//  Endpoint.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 14/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation

protocol EndpointProtocol {
    var baseURL:URL {get}
    var path:String {get}
}

enum Endpoint {
    case cities
    case rating(cityId: String)
    case people(cityId:String)
}

extension Endpoint:EndpointProtocol {
    var baseURL:URL {
        return URL(string: "https://run.mocky.io/v3")!
    }
    var path:String {
        switch self {
        case .cities:
            return "/ae7496a1-d8ec-40a1-9557-98ca669a237f"
        case .rating(_): //param should be used to create path, but for demo purpose leave it untouched
            return "/a97f5352-60ee-4d90-8f2d-f0dd7dbd2d6e"
        case .people(_): //param should be used to create path, but for demo purpose leave it untouched
            return "/c0efb1b0-864e-4638-9281-a2bf28a5c240"
        }
    }
}
