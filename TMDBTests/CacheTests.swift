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
    
    let favoritesKey = "favorites"
    let moviesKey = "movies"
    
    let testMovie = Movie(voteCount: 1, movieId: 1, video: true, voteAverage: 5, title: "test", popularity: 1.2, posterPath: "test", originalLanguage: "en", originalTitle: "test", genreIds: [1], backdropPath: "test", adult: false, overview: "test", releaseDate: "testDate")
    
    func testAddObjectToFavoritesCache() {
        let testInt = 5
        let set: Set<Int> = [testInt]
        let favoritesCache = FavoritesCache(TestingState.notTesting)
        favoritesCache.setObject(set, key: favoritesKey)
        let cachedSet: Set<Int>? = favoritesCache.getObject(favoritesKey)
        XCTAssertNotNil(cachedSet)
    }
    
    func testAddObjectToFavoritesCacheTesting() {
        let testInt = 5
        let set: Set<Int> = [testInt]
        let favoritesCache = FavoritesCache(TestingState.testing)
        favoritesCache.removeObject(favoritesKey)
        favoritesCache.setObject(set, key: favoritesKey)
        let cachedSet: Set<Int>? = favoritesCache.getObject(favoritesKey)
        XCTAssertNil(cachedSet)
    }
    
    func testRemoveObjectFromFavoritesCache() {
        let key = "favorites"
        let testInt = 5
        let set: Set<Int> = [testInt]
        let favoritesCache = FavoritesCache(TestingState.notTesting)
        favoritesCache.setObject(set, key: favoritesKey)
        favoritesCache.removeObject(key)
        let cachedSet: Set<Int>? = favoritesCache.getObject(favoritesKey)
        XCTAssertNil(cachedSet)
    }
    
    func testAddObjectToMoviesCache() {
        let movies = [testMovie]
        let moviesCache = MoviesCache(TestingState.notTesting)
        moviesCache.setObject(movies, key: moviesKey)
        let cachedMovies: [Movie]? = moviesCache.getObject(moviesKey)
        XCTAssertNotNil(cachedMovies)
    }
    
    func testAddObjectToMoviesCacheTesting() {
        let movies = [testMovie]
        let moviesCache = MoviesCache(TestingState.testing)
        moviesCache.removeObject(moviesKey)
        moviesCache.setObject(movies, key: moviesKey)
        let cachedMovies: [Movie]? = moviesCache.getObject(moviesKey)
        XCTAssertNil(cachedMovies)
    }
    
    func testRemoveObjectFromMoviesCache() {
        let movies = [testMovie]
        let moviesCache = MoviesCache(TestingState.notTesting)
        moviesCache.setObject(movies, key: moviesKey)
        moviesCache.removeObject(moviesKey)
        XCTAssertNil(moviesCache.getObject(moviesKey))
    }
}
