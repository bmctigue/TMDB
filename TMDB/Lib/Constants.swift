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
    static let apiKey = "1e1c266b3ca81dad5aea7386cd74c596"
    static let apiKeyParam = "api_key"
    static let pagesKeyParam = "total_pages"
    static let pagesCount = "1"
    static let movieQueryItems = [URLQueryItem(name: Constants.apiKeyParam, value: apiKey), URLQueryItem(name: Constants.pagesKeyParam, value: Constants.pagesCount)]
    static let imageQueryItems = [URLQueryItem(name: Constants.apiKeyParam, value: apiKey)]
    
    enum Movie {
        struct Data {
            static let host = "api.themoviedb.org"
            static let path = "/3/movie/now_playing"
        }
        
        struct PosterImage {
            static let host = "image.tmdb.org"
            static let path = "/t/p/w500"
        }
    }
}
