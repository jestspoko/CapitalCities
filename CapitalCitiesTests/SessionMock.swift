//
//  SessionMock.swift
//  CapitalCitiesTests
//
//  Created by Lukasz Czechowicz on 15/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation
@testable import CapitalCities

class SessionMock:NetworkSession {
    var data: Data?
    var error: Error?
    var response:URLResponse?
    
    func loadData(from request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, response, error)
    }
    
    
}

