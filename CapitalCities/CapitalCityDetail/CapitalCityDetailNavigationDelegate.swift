//
//  CapitalCityDetailNavigationDelegate.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation

protocol CapitalCityDetailNavigationDelegate {
    func show(peopleVisited:Array<PersonModel>)
    func reloadParentCitiesList()
}
