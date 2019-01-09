//
//  Movie.swift
//  Tally
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Unbox

typealias Movie = Result

struct MoviePage {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Result]
}

extension MoviePage: Unboxable {
    init(unboxer: Unboxer) throws {
        self.page = try unboxer.unbox(key: "page")
        self.totalResults = try unboxer.unbox(key: "total_results")
        self.totalPages = try unboxer.unbox(key: "total_pages")
        self.results = try unboxer.unbox(key: "results")
    }
}

struct Result: Codable {
    var voteCount: Int
    var movieId: Int
    var video: Bool
    var voteAverage: Int
    var title: String
    var popularity: Double
    var posterPath: String
    var originalLanguage: String
    var originalTitle: String
    var genreIds: [Int]
    var backdropPath: String
    var adult: Bool
    var overview: String
    var releaseDate: String
}

extension Result: Unboxable {
    init(unboxer: Unboxer) throws {
        self.voteCount = try unboxer.unbox(key: "vote_count")
        self.movieId = try unboxer.unbox(key: "id")
        self.video = try unboxer.unbox(key: "video")
        self.voteAverage = try unboxer.unbox(key: "vote_average")
        self.title = try unboxer.unbox(key: "title")
        self.popularity = try unboxer.unbox(key: "popularity")
        self.posterPath = try unboxer.unbox(key: "poster_path")
        self.originalLanguage = try unboxer.unbox(key: "original_language")
        self.originalTitle = try unboxer.unbox(key: "original_language")
        self.genreIds = try unboxer.unbox(key: "genre_ids")
        self.backdropPath = try unboxer.unbox(key: "backdrop_path")
        self.adult = try unboxer.unbox(key: "adult")
        self.overview = try unboxer.unbox(key: "overview")
        self.releaseDate = try unboxer.unbox(key: "release_date")
    }
}
