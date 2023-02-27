//
//  MoviesInteractorTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 1/4/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB
@testable import Tiguer

class MoviesInteractorTests: XCTestCase {
    
    typealias Model = Movie
    typealias ViewModel = Movies.ViewModel
    
    let movie1 = Movie(voteCount: 0, movieId: 1, video: false, voteAverage: 1, title: "test", popularity: 50, posterPath: "", originalLanguage: "en", originalTitle: "test", genreIds: [0], backdropPath: "", adult: false, overview: "test", releaseDate: "11-03-18")
    
    let movie2 = Movie(voteCount: 0, movieId: 2, video: false, voteAverage: 1, title: "test", popularity: 100, posterPath: "", originalLanguage: "en", originalTitle: "test", genreIds: [0], backdropPath: "", adult: false, overview: "test", releaseDate: "11-03-18")
    
    let cacheKey = "movies"
    var viewModels = [ViewModel]()
    
    func testFetchItemsForAllMovies() {
        let store = LocalDataStore(Movies.Builder.moviesAssetName)
        let dataAdapter = Movies.MoviesDataAdapter<Movie>()
        let modelFactory = Movies.ModelFactory<Movie>(store, dataAdapter: dataAdapter, cacheKey: cacheKey)
        let presenter = Movies.Presenter<Movie, Movies.ViewModel>()
        let sut = Movies.Interactor<Movie, Movies.Presenter, Movies.ModelFactory>(presenter, modelFactory: modelFactory)
        let request = Request()
        let urlGenerator = MoviesDataUrl(request)
        let url = urlGenerator.url()!
        Task.init {
            do {
                try await sut.refreshModels(request, url: url)
                let dynamicModels = presenter.getDynamicModels()
                XCTAssertNotNil(dynamicModels.value.count == 4)
            }
        }
    }

    func testUpdateFavorites() {
        let store = LocalDataStore(Movies.Builder.moviesAssetName)
        let dataAdapter = Movies.MoviesDataAdapter<Movie>()
        let modelFactory = Movies.ModelFactory<Movie>(store, dataAdapter: dataAdapter, cacheKey: cacheKey)
        let testId = String(movie1.movieId)
        let presenter = Movies.Presenter<Model, ViewModel>()
        let sut = Movies.Interactor<Movie, Movies.Presenter, Movies.ModelFactory<Movie>>(presenter, modelFactory: modelFactory)
        sut.updateFavorites(SelectionState.selected(testId))
        XCTAssertTrue(sut.getFavorites().contains(testId))
        sut.updateFavorites(SelectionState.unSelected(testId))
        XCTAssertFalse(sut.getFavorites().contains(testId))
    }

    func testFilterAllModelsByState() {
        let store = LocalDataStore(Movies.Builder.moviesAssetName)
        let dataAdapter = Movies.MoviesDataAdapter<Movie>()
        let modelFactory = Movies.ModelFactory<Movie>(store, dataAdapter: dataAdapter, cacheKey: cacheKey)
        let presenter = Movies.Presenter<Model, ViewModel>()
        let sut = Movies.Interactor<Movie, Movies.Presenter, Movies.ModelFactory>(presenter, modelFactory: modelFactory)
        presenter.models = [movie1, movie2]
        presenter.updateBaseViewModels()
        sut.filterModelsByState(MovieFilterState.all)
        let filteredModels = presenter.getModels()
        XCTAssert(filteredModels.count == 2)
    }

    func testFilterModelsByState() {
        let store = LocalDataStore(Movies.Builder.moviesAssetName)
        let dataAdapter = Movies.MoviesDataAdapter<Movie>()
        let modelFactory = Movies.ModelFactory<Movie>(store, dataAdapter: dataAdapter, cacheKey: cacheKey)
        let testId = String(movie1.movieId)
        let presenter = Movies.Presenter<Model, ViewModel>()
        presenter.models = [movie1, movie2]
        presenter.updateBaseViewModels()
        let sut = Movies.Interactor<Movie, Movies.Presenter, Movies.ModelFactory>(presenter, modelFactory: modelFactory)
        sut.updateFavorites(SelectionState.selected(testId))
        sut.filterModelsByState(MovieFilterState.favorite)
        let dynamicModels = presenter.getDynamicModels()
        XCTAssert(dynamicModels.value.count == 1)
    }

    func testSortModelsByState() {
        let store = LocalDataStore(Movies.Builder.moviesAssetName)
        let dataAdapter = Movies.MoviesDataAdapter<Movie>()
        let modelFactory = Movies.ModelFactory<Movie>(store, dataAdapter: dataAdapter, cacheKey: cacheKey)
        let presenter = Movies.Presenter<Model, ViewModel>()
        presenter.models = [movie1, movie2]
        presenter.updateBaseViewModels()
        let sut = Movies.Interactor<Movie, Movies.Presenter, Movies.ModelFactory>(presenter, modelFactory: modelFactory)
        sut.sortModelsByState(MovieSortState.none)
        var dynamicModels = presenter.getDynamicModels()
        XCTAssert(dynamicModels.value.first!.movieId == movie1.movieId)
        sut.sortModelsByState(MovieSortState.descending)
        dynamicModels = presenter.getDynamicModels()
        XCTAssert(dynamicModels.value.first!.movieId == movie2.movieId)
        sut.sortModelsByState(MovieSortState.ascending)
        dynamicModels = presenter.getDynamicModels()
        XCTAssert(dynamicModels.value.first!.movieId == movie1.movieId)
    }
}
