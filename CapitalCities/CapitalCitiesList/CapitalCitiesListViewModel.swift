//
//  CapitalCitiesListViewModel.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation

class CapitalCitiesListViewModel:BaseViewModel {
    let nav:CapitalCitiesNavigationDelegate
    
    /// holds orginal model data. used for filtering purposes
    private var originalData:Array<CityModel> = []
    
    //holds model data in current state
    private var data:Array<CityModel> = []
    private var favouriteFilterIsOn = false
    private var api:Api
    private var database:Database
    private var thumbnails:[String:Data?] = [:]
    
    
    /// whenever view is using favourite filtering
    var isFiltered:Bool {
        return favouriteFilterIsOn
    }
    
    
    /// fired to force UI refresh
    var uiRefresh:(()->())?
    
    
    /// fired when async task started
    var activityStart:(()->())?
    
    
    /// fired when async task completed
    var activityCompleted:(()->())?
    
    /// fired to handle possible errors
    var errorHandler:((_ errorDescription:String)->())?
    init(nav:CapitalCitiesNavigationDelegate, api:Api, database:Database) {
        self.nav = nav
        self.database = database
        self.originalData = data
        self.api = api
        super.init()
        
        self.title = "Capital Cities"
    }
    
    
    /// loads cities model array
    func getCities() {
        self.activityStart?()
        self.api.cities(completion: { (cities) in
            self.activityCompleted?()
            self.data = cities
            self.originalData = cities
            self.uiRefresh?()
        }) { (e) in
            self.activityCompleted?()
            self.errorHandler?(e.localizedDescription)
        }
    }
    
    
    /// trying to load thumbnail image. If error fails silently.
    /// Possible improvment: useage of placeholder image in case of loading error
    /// - Parameters:
    ///   - url: url to image
    ///   - cityId: id for coresponding image
    ///   - completion: fired when completed with imageData
    func downloadThumbnail(url:URL, cityId:String, completion:@escaping (_ imageData:Data)->()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            //in case of error of any kind, do nothing - silent error. In real world app, we should
            //provide placeholder image to cover all cases
            if let _ = error {
                return
            }
            
            guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
                return
            }
            guard let d = data else {
                return
            }
            
            self.thumbnails[cityId] = d
            DispatchQueue.main.async {
                completion(d)
            }
            
        }.resume()
    }
    
    
    /// returns list items number
    var itemsNumber:Int {
        return data.count
    }
    
    
    /// gets city for given index
    /// - Parameter index: index
    /// - Returns: possible city model
    func city(at index:Int) -> CityModel? {
        guard index < data.count else { return nil }
        
        return data[index]
    }
    
    
    /// checks whenever city is favourite or not
    /// - Parameter cityId: id of city model
    /// - Returns: bool
    func checkCityFavourite(cityId:String)->Bool {
        return self.database.loadFavouriteState(for: cityId)
    }
    
    
    /// performs favourite filtering
    func favouriteFilter() {
        self.favouriteFilterIsOn = !self.favouriteFilterIsOn
        self.data = self.favouriteFilterIsOn ? self.originalData.filter{self.checkCityFavourite(cityId: $0.id)} : self.originalData
        
        self.uiRefresh?()
    }
    
    
    /// selects item at index
    /// - Parameter index: index
    func select(at index:Int) {
        
        guard index < data.count else { fatalError("selected item is from outside range!") }
        if let city = self.city(at: index) {
            self.nav.showDetail(with: city, isCityFavourite: self.checkCityFavourite(cityId: city.id), imageData: self.thumbnails[city.id] ?? nil)
        }
        
    }
}

