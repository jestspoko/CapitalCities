//
//  PeopleVisitedViewModel.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation


class PeopleVisitedViewModel:BaseViewModel {
    private var peopleList:Array<PersonModel> = []
    private let nav:PeopleVisitedFlowNavigationDelegate
    init(peopleList:Array<PersonModel>, nav:PeopleVisitedFlowNavigationDelegate) {
        self.peopleList = peopleList
        self.nav = nav
        super.init()
        
        self.title = NSLocalizedString("People Visited", comment: "")
    }
    
    
    /// gets PersonModel at given index
    /// - Parameter index: index Int
    /// - Returns: possible PersonModel
    func person(at index:Int)-> PersonModel?  {
        guard index < peopleList.count else { return nil }
        
        return peopleList[index]
    }
    
    
    /// returnes people list count
    var peoplesCount:Int {
        return self.peopleList.count
    }
    
    
    /// sends info to close list view
    func dismiss() {
        self.nav.closeList()
    }
}
