//
//  AppError.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 14/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation

enum AppError:LocalizedError {
    case statusCode
    case noData
}

extension AppError {
    var errorDescription: String? {
        switch self {
        case .statusCode:
            return "Wrong status code!"
        case .noData:
            return "No Data!"
        }
    }
}
