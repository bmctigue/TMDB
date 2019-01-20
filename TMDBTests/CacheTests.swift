//
//  CacheTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB

class CacheTests: XCTestCase {
    
    let testMovie = Movie(voteCount: 1, movieId: 1, video: true, voteAverage: 5, title: "test", popularity: 1.2, posterPath: "test", originalLanguage: "en", originalTitle: "test", genreIds: [1], backdropPath: "test", adult: false, overview: "test", releaseDate: "testDate")
    
    override func setUp() {
        AppStateManager.shared.updateCachingState(.caching)
    }
    
    func testAddObjectToFavoritesCache() {
        let key = "favorites"
        let testInt = 5
        let set: Set<Int> = [testInt]
        let favoritesCache = FavoritesCache(AppStateManager.shared)
        favoritesCache.setObject(set, key: key)
        let cachedSet: Set<Int> = favoritesCache.getObject(key)
        XCTAssert(cachedSet.contains(testInt))
    }
    
    func testRemoveObjectFromFavoritesCache() {
        let key = "favorites"
        let testInt = 5
        let set: Set<Int> = [testInt]
        let favoritesCache = FavoritesCache(AppStateManager.shared)
        favoritesCache.setObject(set, key: key)
        favoritesCache.removeObject(key)
        XCTAssertNil(favoritesCache.getObject(key))
    }
    
    func testAddObjectToMoviesCache() {
        let key = "movies"
        let movies = [testMovie]
        let moviesCache = MoviesCache(AppStateManager.shared)
        moviesCache.setObject(movies, key: key)
        let cachedMovies: [Movie] = moviesCache.getObject(key)
        XCTAssert(cachedMovies.count == 1)
    }
    
    func testRemoveObjectFromMoviesCache() {
        let key = "movies"
        let movies = [testMovie]
        let moviesCache = MoviesCache(AppStateManager.shared)
        moviesCache.setObject(movies, key: key)
        moviesCache.removeObject(key)
        XCTAssertNil(moviesCache.getObject(key))
    }
}
