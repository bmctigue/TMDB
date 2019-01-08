//
//  FavoritesManagerTests.swift
//  TallyTests
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import Tally

class FavoritesManagerTests: XCTestCase {
    
    let movie1 = Movie(voteCount: 0, movieId: 1, video: false, voteAverage: 1, title: "test", popularity: 0, posterPath: "", originalLanguage: "en", originalTitle: "test", genreIds: [0], backdropPath: "", adult: false, overview: "test", releaseDate: "11-03-18")
    
    let movie2 = Movie(voteCount: 0, movieId: 2, video: false, voteAverage: 1, title: "test", popularity: 0, posterPath: "", originalLanguage: "en", originalTitle: "test", genreIds: [0], backdropPath: "", adult: false, overview: "test", releaseDate: "11-03-18")

    func testUpdateFavorites() {
        let movieId = 5
        let manager = Movies.FavoritesManager()
        manager.updateFavorites(.selected(movieId))
        XCTAssertTrue(manager.getFavorites().contains(movieId))
        
        manager.updateFavorites(.unSelected(movieId))
        XCTAssertFalse(manager.getFavorites().contains(movieId))
        
    }
}
