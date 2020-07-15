//
//  CapitalCitiesNavigationDelegate.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation

protocol CapitalCitiesNavigationDelegate {
    func showDetail(with city:CityModel, isCityFavourite:Bool, imageData:Data?)
}
