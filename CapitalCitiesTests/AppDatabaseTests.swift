//
//  AppDatabaseTests.swift
//  CapitalCitiesTests
//
//  Created by Lukasz Czechowicz on 15/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation
import XCTest
@testable import CapitalCities

class AppDatabaseTests:XCTestCase {
    var database:Database!
    override func setUp() {
        database = AppDatabase()
        super.setUp()
    }
    
    override func tearDown() {
        database.clear()
        super.tearDown()
    }
    
    func testGetFavValueForRandomCityIdFalse() {
        XCTAssertFalse(database.loadFavouriteState(for: "some_value"))
    }
    
    func testSaveFalseAndGetFavValueFalse() {
        let cityId = "some_id"
        database.saveFavouriteState(state: false, for: cityId)
        XCTAssertFalse(database.loadFavouriteState(for: cityId))
    }
    func testSaveTrueAndGetFavValueTrue() {
        let cityId = "some_id"
        database.saveFavouriteState(state: true, for: cityId)
        XCTAssertTrue(database.loadFavouriteState(for: cityId))
    }
}
