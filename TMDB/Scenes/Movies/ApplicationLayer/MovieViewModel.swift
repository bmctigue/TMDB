//
//  MovieViewModel.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Tiguer

extension Movies {
    struct ViewModel: Comparable, Equatable {
        
        lazy var imageUrlGenerator = MoviesImageUrl(Request())
        
        let movieId: Int
        let title: String
        let overview: String
        let releaseDate: String
        let posterPath: String
        let popularity: Double
        var formattedPopularity: String {
            return "Popularity: \(Int(popularity))"
        }
        
        init(movieId: Int, title: String, overview: String, releaseDate: String, posterPath: String, popularity: Double) {
            self.movieId = movieId
            self.title = title
            self.overview = overview
            self.releaseDate = releaseDate
            self.posterPath = posterPath
            self.popularity = popularity
        }
        
        mutating func postPathUrl() -> URL? {
            guard !posterPath.isEmpty else {
                return nil
            }
            let path = "\(Constants.Movie.PosterImage.path)\(posterPath)"
            self.imageUrlGenerator.updatePath(path)
            return self.imageUrlGenerator.url()
        }
        
        static func == (lhs: Movies.ViewModel, rhs: Movies.ViewModel) -> Bool {
            return lhs.movieId == rhs.movieId
        }
        
        static func < (lhs: Movies.ViewModel, rhs: Movies.ViewModel) -> Bool {
            return lhs.popularity < rhs.popularity
        }
    }
}
