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
    
    let movie1 = Movie(voteCount: 0, movieId: 1, video: false, voteAverage: 1, title: "test", popularity: 0, posterPath: "", originalLanguage: "en", originalTitle: "test", genreIds: [0], backdropPath: "", adult: false, overview: "test", releaseDate: "11-03-18")
    
    let movie2 = Movie(voteCount: 0, movieId: 2, video: false, voteAverage: 1, title: "test", popularity: 0, posterPath: "", originalLanguage: "en", originalTitle: "test", genreIds: [0], backdropPath: "", adult: false, overview: "test", releaseDate: "11-03-18")
    
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
    
    func testUpdateFavorites() {
        let movieId = 5
        var presenter = Movies.Presenter()
        presenter.updateFavorites(.selected(movieId))
        XCTAssertTrue(presenter.getFavorites().contains(movieId))
        
        presenter.updateFavorites(.unSelected(movieId))
        XCTAssertFalse(presenter.getFavorites().contains(movieId))
        
    }
    
    func testGetModels() {
        let models = [movie1, movie2]
        let presenter = Movies.Presenter(models)
        XCTAssert(presenter.getModels().count == models.count)
    }
}
