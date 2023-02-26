//
//  MoviesDecoratorTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 2/26/23.
//  Copyright © 2023 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB
@testable import Tiguer

class MoviesDecoratorTests: XCTestCase {
    
    typealias Model = Movie
    typealias ViewModel = Movies.ViewModel
    
    let movie1 = Movie(voteCount: 0, movieId: 1, video: false, voteAverage: 1, title: "test", popularity: 50, posterPath: "", originalLanguage: "en", originalTitle: "test", genreIds: [0], backdropPath: "", adult: false, overview: "test", releaseDate: "11-03-18")
    
    let movie2 = Movie(voteCount: 0, movieId: 2, video: false, voteAverage: 1, title: "test", popularity: 100, posterPath: "", originalLanguage: "en", originalTitle: "test", genreIds: [0], backdropPath: "", adult: false, overview: "test", releaseDate: "11-03-18")

    func testFilterDecoratorNoFavorites() {
        let presenter = Movies.Presenter<Model, ViewModel>()
        presenter.models = [movie1, movie2]
        presenter.updateBaseViewModels()
        presenter.updateViewModels()
        var decorator = Movies.MovieSelectedFilterDecorator<ViewModel>()
        decorator.filterState = MovieFilterState.all
        let viewModels = decorator.decorate(presenter.viewModels)
        XCTAssertEqual(viewModels.count, presenter.models.count)
    }
    
    func testSortDecoratorAscending() {
        let presenter = Movies.Presenter<Model, ViewModel>()
        presenter.models = [movie1, movie2]
        presenter.updateBaseViewModels()
        presenter.updateViewModels()
        var decorator = Movies.MoviePopularitySortDecorator<ViewModel>()
        decorator.sortState = MovieSortState.ascending
        let viewModels = decorator.decorate(presenter.viewModels)
        XCTAssert(viewModels.first?.popularity == movie1.popularity)
    }
    
    func testSortDecoratorDescending() {
        let presenter = Movies.Presenter<Model, ViewModel>()
        presenter.models = [movie1, movie2]
        presenter.updateBaseViewModels()
        presenter.updateViewModels()
        var decorator = Movies.MoviePopularitySortDecorator<ViewModel>()
        decorator.sortState = MovieSortState.descending
        let viewModels = decorator.decorate(presenter.viewModels)
        XCTAssert(viewModels.first?.popularity == movie2.popularity)
    }
}
