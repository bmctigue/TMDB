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
    
    typealias ViewModel = Movies.ViewModel
    
    let cacheKey = "movies"
    private lazy var store = LocalStore(Movies.Builder.moviesAssetName)
    private lazy var dataAdapter = Movies.UnboxDataAdapter()
    private lazy var service = Movies.Service<Movie, Movies.UnboxDataAdapter>(store, dataAdapter: dataAdapter, cacheKey: cacheKey)
    private lazy var presenter = Movies.Presenter([])
    var viewModels = [ViewModel]()
    
    func testFetchItemsForAllMovies() {
        let presenter = Movies.Presenter([], main: SyncQueue.global, background: SyncQueue.background)
        let sut = Movies.Interactor<Movie, Movies.Presenter, Movies.Service>(service, presenter: presenter)
        sut.fetchItems(Request())
        let dynamicModels = presenter.getDynamicModels()
        XCTAssertNotNil(dynamicModels.value.count == 4)
    }
}
