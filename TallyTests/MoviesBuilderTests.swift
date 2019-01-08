//
//  MoviesBuilderTests.swift
//  TallyTests
//
//  Created by Bruce McTigue on 12/30/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import Tally

class MoviesBuilderTests: XCTestCase {
    
    lazy var store = LocalStore(Builder.App.moviesAssetName)
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
