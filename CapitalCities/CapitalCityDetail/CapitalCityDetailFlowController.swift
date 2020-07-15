//
//  CapitalCityDetailFlowController.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation


class CapitalCityDetailFlowController:FlowController, CapitalCityDetailNavigationDelegate {
    var childFlow: FlowController?
    var configure: FlowConfigure
    
    private var imageData:Data?
    private var city:CityModel?
    private var isCityFavourite:Bool = false
    private var api:Api?
    private var database:Database?
    
    required init(configure: FlowConfigure) {
        self.configure = configure
    }
    
    init(configure:FlowConfigure, city:CityModel, isCityFavourite:Bool, imageData:Data?, api:Api, database:Database) {
        self.configure = configure
        self.city = city
        self.api = api
        self.isCityFavourite = isCityFavourite
        self.database = database
        self.imageData = imageData
    }
    
    func start() {
        
        guard let city = self.city, let api = self.api, let database = self.database else { return }
        
        let viewModel = CapitalCityDetailViewModel(city: city, isFavourite: isCityFavourite, imageData: self.imageData, nav: self, api:api, database:database)
        let viewController = CapitalCityDetailViewController(viewModel:viewModel)
        
        self.configure.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// fires people visited flow controller
    /// - Parameter peopleVisited: user content array to show
    func show(peopleVisited: Array<PersonModel>) {
        let configure = FlowConfigure(window: self.configure.window, navigationController: self.configure.navigationController, parent: self)
        let flow = PeopleVisitedFlowController(configure: configure, peopleVisited: peopleVisited)
        flow.start()
    }
    
    /// force reload view on parent flow controller
    func reloadParentCitiesList() {
        guard let flow = self.configure.parent as? CapitalCitiesListFlowController else { return }
        flow.reloadList()
    }
}
