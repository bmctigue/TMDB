//
//  MoviesPresenterTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB
@testable import Tiguer

class MoviesPresenterTests: XCTestCase {
    
    typealias Model = Movie
    typealias ViewModel = Movies.ViewModel
    
    let movie1 = Movie(voteCount: 0, movieId: 1, video: false, voteAverage: 1, title: "test", popularity: 50, posterPath: "", originalLanguage: "en", originalTitle: "test", genreIds: [0], backdropPath: "", adult: false, overview: "test", releaseDate: "11-03-18")
    
    let movie2 = Movie(voteCount: 0, movieId: 2, video: false, voteAverage: 1, title: "test", popularity: 100, posterPath: "", originalLanguage: "en", originalTitle: "test", genreIds: [0], backdropPath: "", adult: false, overview: "test", releaseDate: "11-03-18")

    func testUpdateFavorites() {
        let testId = String(movie1.movieId)
        let sut = Movies.Presenter<Model, ViewModel>([], main: SyncQueue.global, background: SyncQueue.background)
        sut.updateFavorites(.selected(testId))
        XCTAssertTrue(sut.getFavorites().contains(testId))
        sut.updateFavorites(.unSelected(testId))
        XCTAssertFalse(sut.getFavorites().contains(testId))
    }

    func testFilterAllModelsByState() {
        let models = [movie1, movie2]
        let sut = Movies.Presenter<Model, ViewModel>(models, main: SyncQueue.global, background: SyncQueue.background)
        sut.filterModelsByState(.all)
        let filteredModels = sut.getModels()
        XCTAssert(filteredModels.count == 2)
    }

    func testFilterModelsByState() {
        let testId = String(movie1.movieId)
        let models = [movie1, movie2]
        let sut = Movies.Presenter<Model, ViewModel>(models, main: SyncQueue.global, background: SyncQueue.background)
        sut.updateFavorites(.selected(testId))
        sut.filterModelsByState(.favorite)
        let dynamicModels = sut.getDynamicModels()
        XCTAssert(dynamicModels.value.count == 1)
    }

    func testSortModelsByState() {
        let models = [movie1, movie2]
        let sut = Movies.Presenter<Model, ViewModel>(models, main: SyncQueue.global, background: SyncQueue.background)
        sut.sortModelsByState(.none)
        var dynamicModels = sut.getDynamicModels()
        XCTAssert(dynamicModels.value.first!.movieId == movie1.movieId)
        sut.sortModelsByState(.descending)
        dynamicModels = sut.getDynamicModels()
        XCTAssert(dynamicModels.value.first!.movieId == movie2.movieId)
        sut.sortModelsByState(.ascending)
        dynamicModels = sut.getDynamicModels()
        XCTAssert(dynamicModels.value.first!.movieId == movie1.movieId)
    }

    func testGetModels() {
        let models = [movie1, movie2]
        let sut = Movies.Presenter<Model, ViewModel>(models, main: SyncQueue.global, background: SyncQueue.background)
        XCTAssert(sut.getModels().count == models.count)
    }
}
