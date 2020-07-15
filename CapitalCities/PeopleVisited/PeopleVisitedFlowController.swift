//
//  PeopleVisitedFlowController.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation

class PeopleVisitedFlowController:FlowController, PeopleVisitedFlowNavigationDelegate {
    var childFlow: FlowController?
    var configure: FlowConfigure
    private var peopleVisited:Array<PersonModel> = []
    required init(configure: FlowConfigure) {
        self.configure = configure
    }
    
    init(configure: FlowConfigure, peopleVisited:Array<PersonModel>) {
        self.configure = configure
        self.peopleVisited = peopleVisited
    }
    
    func start() {
        guard peopleVisited.count > 0 else { return }
        let viewModel = PeopleVisitedViewModel(peopleList: peopleVisited, nav:self)
        let viewController = PeopleVisitedViewController(viewModel: viewModel)
        
        self.configure.navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    func closeList() { //handles classic "button style" closing, in case ios < 13
        self.configure.navigationController?.dismiss(animated: true, completion: nil)
    }
}
