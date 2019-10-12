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
    static let apiKey = "97999d8d7fdb9cafbfc5d93c9c647489"
    static let queryItems = [URLQueryItem(name: Constants.apiKeyString, value: apiKey)]
    static let apiKeyString = "api_key"
    
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
