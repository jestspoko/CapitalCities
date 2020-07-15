//
//  NetworkSession.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 15/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation

protocol NetworkSession {
    func loadData(from request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: request, completionHandler: { data, response, error -> Void in
            completionHandler(data, response, error)
        })

        task.resume()
    }
}
