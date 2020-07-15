//
//  Api.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 14/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation

protocol Api {
    func cities(completion:@escaping(_ cities:Array<CityModel>)->(), failure:@escaping(_ error:Error)->())
    func rating(cityId:String, completion:@escaping(_ rating:Double)->(), failure:@escaping(_ error:Error)->())
    func people(cityId:String, completion:@escaping(_ people:Array<PersonModel>)->(), failure:@escaping(_ error:Error)->())
    
}


