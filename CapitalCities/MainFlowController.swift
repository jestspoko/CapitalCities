//
//  MainFlowController.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation


/// Entry Flow controller for app
class MainFlowController:FlowController {
    var childFlow: FlowController?
    var configure: FlowConfigure
    private let api:Api
    private let database:Database
    required init(configure: FlowConfigure) {
        self.configure = configure
        
        //implementation of Api and Database protocols. Inject them here.
        self.api = AppApi()
        self.database = AppDatabase()
        
    }
    
    func start() {
        if let frame = self.configure.window?.bounds {
            self.configure.navigationController?.view.frame = frame
        }
        
        self.configure.window?.rootViewController = self.configure.navigationController
        self.configure.window?.makeKeyAndVisible()
        
        
        //run list flow controller as first child
        let configure = FlowConfigure(window: self.configure.window, navigationController: self.configure.navigationController, parent: self)
        let listFlow = CapitalCitiesListFlowController(configure: configure, api: api, database:database)
        
        listFlow.start()
    }
}
