//
//  Api.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 14/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation

/// Creates simple rest call to given resource
struct SimpleRest<T:Codable> {
    
    private let session: NetworkSession
    init(session:NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    
    
    /// Implements REST call
    /// - Parameters:
    ///   - url: url to resource
    ///   - method: http method
    ///   - params: possible params
    ///   - completion: completion handler
    ///   - failure: failure handler
    func call(url:URL, method:String, params:[String:String], completion: @escaping(_ response:T)->(), failure: @escaping(_ error:Error)->()) {

        var request = URLRequest(url: url)
        request.httpMethod = method.uppercased()
        if params.keys.count > 0 {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        session.loadData(from: request) { data, response, error -> Void in
            do {
                if let e = error {
                    failure(e)
                    return
                }
                
                guard let d = data else {
                    failure(AppError.noData)
                    return
                }
                
                guard let r = response as? HTTPURLResponse, r.statusCode == 200 else {
                    failure(AppError.statusCode)
                    return
                }
                
                
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(T.self, from: d)
                    completion(response)
            } catch {
                failure(error)
            }
        }
    }
}
