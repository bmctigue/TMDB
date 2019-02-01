//
//  MoviesBuilderTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/30/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB
@testable import Tiguer

class MoviesBuilderTests: XCTestCase {
    
    lazy var store = LocalStore(Movies.Builder.moviesAssetName)
    var resultController: UINavigationController?

    func testMoviesBuilder() {
        let expectation = self.expectation(description: "run")
        let sut = Movies.Builder.init(with: "test", store: store, state: .all)
        sut.run { controller in 
            resultController = controller as? UINavigationController
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(resultController)
    }
}
