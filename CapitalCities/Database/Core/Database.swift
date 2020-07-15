//
//  Database.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 14/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation

protocol Database {
    func saveFavouriteState(state:Bool, for cityId:String)
    func loadFavouriteState(for cityId:String) -> Bool
    func clear()
}
