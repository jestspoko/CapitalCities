//
//  City.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation



/// Holds City description
struct CityModel:Codable {
    var name:String
    var id:String
    var imageURL:URL?
}
