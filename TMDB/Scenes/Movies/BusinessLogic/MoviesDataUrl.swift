//
//  MoviesDataUrl.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/23/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

class MoviesDataUrl: URLGenerator {
    
    private lazy var components: URLComponents = URLComponents()
    
    init(_ request: Request) {
        self.components.host = Constants.Movie.Data.host
        self.components.path = Constants.Movie.Data.path
        self.components.scheme = Constants.scheme
        let apiQueryItem = URLQueryItem(name: Constants.apiKeyString, value: Constants.apiKey)
        if var queryItems = queryItemsFromRequest(request) {
            queryItems.append(apiQueryItem)
            self.components.queryItems = queryItems
        } else {
            self.components.queryItems = [apiQueryItem]
        }
    }
    
    func url() -> URL? {
        return components.url
    }
}
