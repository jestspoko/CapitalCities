//
//  CapitalCityDetailViewModel.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation

class CapitalCityDetailViewModel:BaseViewModel {
    private let city:CityModel
    private let imageData:Data?
    private let nav:CapitalCityDetailNavigationDelegate
    private var isCityFavourite:Bool
    private let api:Api
    private let database:Database
    
    
    /// holds people array loaded from async request
    var people:Array<PersonModel> = []
    
    
    /// holds city rating, valid if > 0
    var rating:Double = 0.0
    
    
    /// handler fires when rating value should be updated
    var ratingHandler:(()->())?
    
    
    /// handler fires when people visited array is updated
    var peopleVisitedHandler:(()->())?
    
    
    /// fires when erros occurs
    var errorHandler:((_ errorDescription:String)->())?
    
    init(city:CityModel, isFavourite:Bool, imageData:Data?, nav:CapitalCityDetailNavigationDelegate, api:Api, database:Database) {
        self.city = city
        self.nav = nav
        self.database = database
        self.api = api
        self.isCityFavourite = isFavourite
        self.imageData = imageData
        super.init()
        self.title = city.name
    }
    
    
    /// gets array of PersonModel for given city
    func peopleVisited() {
        self.api.people(cityId: self.city.id, completion: { people in
            self.people = people
            self.peopleVisitedHandler?()
        }) { e in
            self.errorHandler?(e.localizedDescription)
        }
    }
    
    
    /// gets given city rating
    func cityRating() {
        self.api.rating(cityId: self.city.id, completion: { rating in
            self.rating = rating
            self.ratingHandler?()
        }) { e in
            self.errorHandler?(e.localizedDescription)
        }
    }
    
    
    /// changes and returns favourite state
    /// - Parameter completed: fires when change performed successfully
    /// - Returns: current favourite state
    func changeFavouriteState(completed:(_ state:Bool)->()) {
        let currentState = self.database.loadFavouriteState(for: self.city.id)
        self.database.saveFavouriteState(state: !currentState, for: self.city.id)
        completed(!currentState)
        
        //reload view in parent flow controller
        self.nav.reloadParentCitiesList()
    }
    
    
    /// show people visited list
    func showPeopleVisited() {
        self.nav.show(peopleVisited: self.people)
    }
    
    
    /// returs whenever city is favourite or not
    var isFavourite:Bool {
        return self.isCityFavourite
    }
    
    
    /// holds name for given city
    var cityName:String {
        return self.city.name
    }
    
    
    /// holds image data
    var cityImageData:Data? {
        return self.imageData
    }
}
