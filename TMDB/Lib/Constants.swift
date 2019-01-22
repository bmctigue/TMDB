//
//  Constants.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/22/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

enum Constants {
    static let scheme = "https"
    static let apiKey = "ac975fc8b7261ca68365d2cf95286764"
    static let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
    
    enum Movie {
        struct Data {
            static let host = "api.themoviedb.org"
            static let path = "/3/movie/popular"
        }
        
        struct PosterImage {
            static let host = "image.tmdb.org"
            static let path = "/t/p/w500"
        }
    }
}
