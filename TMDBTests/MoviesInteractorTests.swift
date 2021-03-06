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
    private lazy var dataAdapter = Movies.UnboxDataAdapter<Movie>()
    private lazy var service = Tiguer.Service<Movie, Movies.UnboxDataAdapter>(store, dataAdapter: dataAdapter, cacheKey: cacheKey)
    var viewModels = [ViewModel]()
    
    func testFetchItemsForAllMovies() {
        let presenter = Movies.Presenter<Movie, Movies.ViewModel>([], main: SyncQueue.global, background: SyncQueue.background)
        let sut = Tiguer.Interactor<Movie, Movies.Presenter, Tiguer.Service>(presenter, service: service)
        let request = Request()
        let urlGenerator = MoviesDataUrl(request)
        let url = urlGenerator.url()!
        sut.fetchItems(request, url: url)
        let dynamicModels = presenter.getDynamicModels()
        XCTAssertNotNil(dynamicModels.value.count == 4)
    }
}
