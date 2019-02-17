//
//  MoviesServiceTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB
@testable import Tiguer

class ServiceTests: XCTestCase {
    
    let assetName = Movies.Builder.moviesAssetName
    lazy var dataAdapter = Movies.UnboxDataAdapter<Movie>()
    let cacheKey = "movies"

    func testService() {
        let expectation = self.expectation(description: "fetchItems")
        var results = [Movie]()
        let store = LocalStore(assetName)
        let request = Request()
        
        let sut = Tiguer.Service<Movie, Movies.UnboxDataAdapter>(store, dataAdapter: dataAdapter, cacheKey: cacheKey)
        sut.updateCacheTestingState(.testing)
        let urlGenerator = MoviesDataUrl(request)
        let url = urlGenerator.url()!
        sut.fetchItems(request, url: url) { movies in
            results = movies
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(results.count > 0)
    }
}
