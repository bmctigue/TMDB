//
//  URLManager.swift
//  Tally
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

final class URLManager {
    
    let scheme = "https"
    let host = "api.themoviedb.org"
    let path = "/3/movie/popular"
    let apiKey = "ac975fc8b7261ca68365d2cf95286764"
    
    func moviesURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        return components
    }
    
    func fetchMoviesURL(_ page: String = "1") -> URL? {
        var components = moviesURLComponents()
        components.queryItems?.append(URLQueryItem(name: "page", value: page))
        return components.url
    }
    
    func fetchMoviePosterURL(_ posterPath: String) -> URL? {
        var components = moviesURLComponents()
        components.host = "image.tmdb.org"
        components.path = "/t/p/w500\(posterPath)"
        return components.url
    }
}
