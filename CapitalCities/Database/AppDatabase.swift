//
//  AppDatabase.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 14/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation


class AppDatabase:Database {
    private let cityPrefix = "city"
    private let defaults = UserDefaults.standard
    func saveFavouriteState(state: Bool, for cityId: String) {
        defaults.set(state, forKey: "\(cityPrefix)_\(cityId)")
    }
    
    func loadFavouriteState(for cityId: String) -> Bool {
        let state = defaults.bool(forKey: "\(cityPrefix)_\(cityId)")
        return state
    }
    
    func clear() {
        guard let appDomain = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
    }
}
