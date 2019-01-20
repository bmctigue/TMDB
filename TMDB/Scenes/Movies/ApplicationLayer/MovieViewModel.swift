//
//  MovieViewModel.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit

extension Movies {
    struct ViewModel {
        let movieId: Int
        let title: String
        let overview: String
        let releaseDate: String
        let posterPath: String
        let popularity: Double
        var formattedPopularity: String {
            return "Popularity: \(Int(popularity))"
        }
    }
}