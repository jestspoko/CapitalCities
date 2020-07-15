//
//  CapitalCitiesListFlowController.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation


class CapitalCitiesListFlowController:FlowController, CapitalCitiesNavigationDelegate {
    var childFlow: FlowController?
    var configure: FlowConfigure
    private var api:Api?
    private var database:Database?
    required init(configure: FlowConfigure) {
        self.configure = configure
    }
    
    init(configure: FlowConfigure, api:Api, database:Database) {
        self.configure = configure
        self.database = database
        self.api = api
    }
    
    func start() {
        
        guard let api = self.api, let database = self.database else { return }
        
        let viewModel = CapitalCitiesListViewModel(nav: self, api:api, database:database)
        let viewController = CapitalCitiesListViewController(viewModel: viewModel)
        
        //fist vc on stack, no animation
        self.configure.navigationController?.pushViewController(viewController, animated: false)
    }
    
    /// opens detail view
    /// - Parameters:
    ///   - city: city model
    ///   - isCityFavourite: whenever city is favorite or not
    ///   - imageData: possible city image data
    func showDetail(with city: CityModel, isCityFavourite:Bool, imageData: Data?) {
        guard let api = self.api, let database = self.database else { return }
        let configure = FlowConfigure(window: self.configure.window, navigationController: self.configure.navigationController, parent: self)
        
        let flow = CapitalCityDetailFlowController(configure: configure, city: city, isCityFavourite: isCityFavourite, imageData: imageData, api: api, database:database)
        
        flow.start()
    }
    
    
    /// finds and reloads view list
    func reloadList() {
        guard let nav = self.configure.navigationController, nav.viewControllers.count >= 2, let vc = nav.viewControllers[nav.viewControllers.count - 2] as? CapitalCitiesListViewController else { return }
        
        vc.refreshView()
        
    }
}
