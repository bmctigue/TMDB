//
//  URLManager.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

final class URLManager {
    
    private var components: URLComponents = URLComponents()
    
    init(host: String = Constants.Movie.Data.host, path: String = Constants.Movie.Data.path, scheme: String = Constants.scheme, apiKey: String? = Constants.apiKey) {
        components.host = host
        components.path = path
        components.scheme = scheme
        if let key = apiKey {
            self.updateQueryItems([URLQueryItem(name: "api_key", value: key)])
        }
    }
    
    func updatePath(_ path: String) {
        components.path = path
    }
    
    func updateQueryItems(_ queryItems: [URLQueryItem]) {
        if var items = components.queryItems {
            items += queryItems
            components.queryItems = items
        } else {
            components.queryItems = queryItems
        }
    }
    
    func url() -> URL? {
        return components.url
    }
}
