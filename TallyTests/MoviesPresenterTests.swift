//
//  MoviesPresenterTests.swift
//  TallyTests
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import Tally

class MoviesPresenterTests: XCTestCase {
    
    let movie1 = Movie(movieId: "1", name: "Movie1", text: "Movie1", price: "1.99", type: .movie, imageUrl: "", image: "")
    let movie2 = Movie(movieId: "2", name: "Movie2", text: "Movie2", price: "2.99", type: .movie, imageUrl: "", image: "")
    
    func testDisplayedMovies() {
        let presenter = Movies.Presenter()
        XCTAssert(presenter.viewModels.count == 0)
    }
    
    func testInitWithDisplayedMovies() {
        let models = [movie1, movie2]
        let presenter = Movies.Presenter(models)
        var resultMovies = [Movies.ViewModel]()
        let expectation = self.expectation(description: "testUpdateViewModels")
        let dynamicModels = presenter.getDynamicModels()
        dynamicModels.addAndNotify(observer: self) {
            resultMovies = dynamicModels.value
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(presenter.viewModels.count == models.count)
        XCTAssert(resultMovies.count == models.count)
    }

    func testUpdateDisplayedMovies() {
        let models = [movie1, movie2]
        var presenter = Movies.Presenter()
        var resultMovies = [Movies.ViewModel]()
        let expectation = self.expectation(description: "testUpdateViewModels")
        let dynamicModels = presenter.getDynamicModels()
        dynamicModels.addObserver(self) {
            resultMovies = dynamicModels.value
            expectation.fulfill()
        }
        let response = Response(models: models)
        presenter.updateViewModels(response)
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(resultMovies.count == models.count)
    }
}
