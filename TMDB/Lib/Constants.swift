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
    static let apiKeyParam = "api_key"
    static let pagesKeyParam = "total_pages"
    static let pagesCount = "1"
    static let movieQueryItems = [URLQueryItem(name: Constants.apiKeyParam, value: apiKey), URLQueryItem(name: Constants.pagesKeyParam, value: Constants.pagesCount)]
    static let imageQueryItems = [URLQueryItem(name: Constants.apiKeyParam, value: apiKey)]
    
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
