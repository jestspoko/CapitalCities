//
//  AppApiTest.swift
//  CapitalCitiesTests
//
//  Created by Lukasz Czechowicz on 15/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//


import XCTest
@testable import CapitalCities

class AppApiTests:XCTestCase {
    var api:AppApi!
    override func setUp() {
        api = AppApi()
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    func testCitiesSuccessfullReturnesResult() {
        let expectation = self.expectation(description: "Returning Values")
        var desiredCites:[CityModel]?
        api.cities(completion: { cities in
            desiredCites = cities
            expectation.fulfill()
        }) { _ in
            
        }
        waitForExpectations(timeout: 5, handler: { e in
            XCTAssertNotNil(desiredCites)
        })
    }
    func testCitiesReturnesMoreThanZeroResults() {
        let expectation = self.expectation(description: "Returning Cities")
        var desiredCites:[CityModel] = []
        api.cities(completion: { cities in
            desiredCites = cities
            expectation.fulfill()
        }) { _ in
            
        }
        waitForExpectations(timeout: 5, handler: { e in
            XCTAssertGreaterThan(desiredCites.count, 0, "returns more than zero cities")
        })
        
    }
    
    func testRatingReturnesValueGreaterZero() {
        let expectation = self.expectation(description: "Returning Rating > 0")
       
        var desiredRating = 0.0
        api.rating(cityId: "some_id", completion: { rating in
            desiredRating = rating
            expectation.fulfill()
        }, failure: { e in
            
        })
        waitForExpectations(timeout: 5, handler: { e in
            XCTAssertGreaterThan(desiredRating, 0, "returns more than zero cities")
        })
        
    }
    
    func testPeopleReturnesGreaterEqualZero() {
        let expectation = self.expectation(description: "Returning People >= 0")
       
        var desiredPeopleCount = 0
        api.people(cityId: "some_id", completion: { people in
            desiredPeopleCount = people.count
            expectation.fulfill()
        }) { e in
            
        }
        waitForExpectations(timeout: 5, handler: { e in
            XCTAssertGreaterThanOrEqual(desiredPeopleCount, 0)
        })
        
    }
}
