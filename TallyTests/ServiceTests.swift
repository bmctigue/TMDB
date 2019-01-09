//
//  MoviesServiceTests.swift
//  TallyTests
//
//  Created by Bruce McTigue on 12/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import Tally

class ServiceTests: XCTestCase {
    
    let assetName = Movies.Builder.moviesAssetName
    lazy var dataAdapter = Movies.UnboxDataAdapter()

    func testService() {
        let expectation = self.expectation(description: "fetchItems")
        var results = [Movie]()
        let store = LocalStore(assetName)
        let request = Request()
        
        let sut = Movies.Service(store, dataAdapter: dataAdapter)
        sut.fetchItems(request) { movies in
            results = movies as! [Movie]
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(results.count > 0)
    }
    
    func testServiceClearCache() {
        let expectation = self.expectation(description: "fetchItems")
        var results = [Movie]()
        let store = LocalStore(assetName)
        let request = Request()
        
        let sut = Movies.Service(store, dataAdapter: dataAdapter)
        sut.moviesCache.removeObject(sut.moviesKey)
        sut.fetchItems(request) { movies in
            results = movies as! [Movie]
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(results.count > 0)
    }
}
