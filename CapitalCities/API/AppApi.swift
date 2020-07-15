//
//  AppApi.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 14/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation


class AppApi:Api {
   
    func cities(completion: @escaping (Array<CityModel>) -> (), failure: @escaping (Error) -> ()) {
        let rest = SimpleRest<[CityModel]>()
        let endpoint = Endpoint.cities
        rest.call(url: endpoint.baseURL.appendingPathComponent(endpoint.path), method: "GET", params: [:], completion: { cities in
            DispatchQueue.main.async {
                completion(cities)
            }
        }) { e in
            DispatchQueue.main.async {
                failure(e)
            }
        }
    }
    
    func rating(cityId: String, completion: @escaping (Double) -> (), failure: @escaping (Error) -> ()) {
        let rest = SimpleRest<RatingModel>()
        let endpoint = Endpoint.rating(cityId: cityId)
        rest.call(url: endpoint.baseURL.appendingPathComponent(endpoint.path), method: "GET", params: [:], completion: { rating in
            DispatchQueue.main.async {
                completion(rating.rating)
            }
        }) { e in
            DispatchQueue.main.async {
                failure(e)
            }
        }
    }
    
    func people(cityId: String, completion: @escaping (Array<PersonModel>) -> (), failure: @escaping (Error) -> ()) {
        let rest = SimpleRest<[PersonModel]>()
        let endpoint = Endpoint.people(cityId: cityId)
        rest.call(url: endpoint.baseURL.appendingPathComponent(endpoint.path), method: "GET", params: [:], completion: { people in
            DispatchQueue.main.async {
                completion(people)
            }
        }) { e in
            DispatchQueue.main.async {
                failure(e)
            }
        }
    }
    
    
}
