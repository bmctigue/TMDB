//
//  MoviesModelFactoryTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB
@testable import Tiguer

class MoviesModelFactoryTests: XCTestCase {
    
    let assetName = Movies.Builder.moviesAssetName
    let cacheKey = "movies"

    func testModelFactory() async throws {
        let store = LocalDataStore(assetName)
        let request = Request()
        let dataAdapter = Movies.MoviesDataAdapter<Movie>()
        let sut = Movies.ModelFactory<Movie>(store, dataAdapter: dataAdapter, cacheKey: cacheKey)
        sut.updateCacheTestingState(.testing)
        let urlGenerator = MoviesDataUrl(request)
        let url = urlGenerator.url()!
        Task.init {
            do {
                let results = try await sut.models(Request(), url: url)
                XCTAssert(results.count > 0)
            }
        }
    }
}
