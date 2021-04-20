//
//  MoviesDataUrl.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/23/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation
import Tiguer

final class MoviesDataUrl: URLGenerator {
    
    private lazy var components: URLComponents = URLComponents()
    
    init(_ request: Request) {
        self.components.host = Constants.Movie.Data.host
        self.components.path = Constants.Movie.Data.path
        self.components.scheme = Constants.scheme
        self.components.queryItems = Constants.movieQueryItems
    }
    
    func url() -> URL? {
        return components.url
    }
}
