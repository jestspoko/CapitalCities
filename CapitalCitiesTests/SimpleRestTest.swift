//
//  SimpleRestTest.swift
//  CapitalCitiesTests
//
//  Created by Lukasz Czechowicz on 15/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import XCTest
@testable import CapitalCities

class SimpleRestTest:XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func testSimpleRestReturnesFailureWhenErrorNotNil() {
        let session = SessionMock()
        session.error = AppError.statusCode
        let rest = SimpleRest<[CityModel]>(session: session)
        let expectation = self.expectation(description: "Returning Error")
        rest.call(url: URL(string: "https://wp.pl/")!, method: "GET", params: [:], completion: { cities in
            
        }) { e in
            expectation.fulfill()
            XCTAssertNotNil(e)
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSimpleRestReturnesFailureWhenDataIsNil() {
        let session = SessionMock()
        let rest = SimpleRest<[CityModel]>(session: session)
        let expectation = self.expectation(description: "Returning Error")
        rest.call(url: URL(string: "https://wp.pl/")!, method: "GET", params: [:], completion: { cities in
            
        }) { e in
            expectation.fulfill()
            XCTAssertNotNil(e)
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testSimpleRestReturnesFailureWhenStatusCodeIsOtherThan200() {
        let session = SessionMock()
        session.response = HTTPURLResponse(url: URL(string: "https://wp.pl/")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        session.data = Data()
        let rest = SimpleRest<[CityModel]>(session: session)
        let expectation = self.expectation(description: "Returning Error")
        rest.call(url: URL(string: "https://wp.pl/")!, method: "GET", params: [:], completion: { cities in
            
        }) { e in
            expectation.fulfill()
            XCTAssertNotNil(e)
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSimpleRestReturnesStatusCodeErrorWhenStatusCodeIsOtherThan200() {
        let session = SessionMock()
        session.response = HTTPURLResponse(url: URL(string: "https://wp.pl/")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        session.data = Data()
        let rest = SimpleRest<[CityModel]>(session: session)
        let expectation = self.expectation(description: "Returning Error")
        rest.call(url: URL(string: "https://wp.pl/")!, method: "GET", params: [:], completion: { cities in
            
        }) { e in
            expectation.fulfill()
            XCTAssertEqual(e as! AppError, AppError.statusCode)
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSimpleRestReturnesFailureWhenDataIsNotJSON() {
        let session = SessionMock()
        session.response = HTTPURLResponse(url: URL(string: "https://wp.pl/")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        session.data = Data()
        let rest = SimpleRest<[CityModel]>(session: session)
        let expectation = self.expectation(description: "Returning Error")
        rest.call(url: URL(string: "https://wp.pl/")!, method: "GET", params: [:], completion: { cities in
            
        }) { e in
            expectation.fulfill()
            XCTAssertNotNil(e)
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSimpleRestReturnesFailureWhenDataIsNotCityModelJSON() {
        let session = SessionMock()
        session.response = HTTPURLResponse(url: URL(string: "https://wp.pl/")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let mock = PersonModel(name: "Łukasz")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        session.data = try! encoder.encode([mock])
        let rest = SimpleRest<[CityModel]>(session: session)
        let expectation = self.expectation(description: "Returning Error")
        rest.call(url: URL(string: "https://wp.pl/")!, method: "GET", params: [:], completion: { cities in
            
        }) { e in
            expectation.fulfill()
            XCTAssertNotNil(e)
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSimpleRestReturnesSuccessWhenDataIsCityModelJSON() {
        let session = SessionMock()
        session.response = HTTPURLResponse(url: URL(string: "https://wp.pl/")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let mock = CityModel(name: "Warsaw", id: "test", imageURL: nil)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        session.data = try! encoder.encode([mock])
        let rest = SimpleRest<[CityModel]>(session: session)
        let expectation = self.expectation(description: "Returning Error")
        rest.call(url: URL(string: "https://wp.pl/")!, method: "GET", params: [:], completion: { cities in
            expectation.fulfill()
            XCTAssertNotNil(cities)
        }) { e in
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSimpleRestReturnesSuccessWheIsCityModelArrayIsGreaterZero() {
        let session = SessionMock()
        session.response = HTTPURLResponse(url: URL(string: "https://wp.pl/")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let mock = CityModel(name: "Warsaw", id: "test", imageURL: nil)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        session.data = try! encoder.encode([mock])
        let rest = SimpleRest<[CityModel]>(session: session)
        let expectation = self.expectation(description: "Returning Error")
        rest.call(url: URL(string: "https://wp.pl/")!, method: "GET", params: [:], completion: { cities in
            expectation.fulfill()
            XCTAssertGreaterThan(cities.count, 0)
        }) { e in
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
