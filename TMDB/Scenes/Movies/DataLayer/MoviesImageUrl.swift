//
//  MoviesImageUrl.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/23/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation
import Tiguer

final class MoviesImageUrl: URLGenerator {

    private lazy var components: URLComponents = URLComponents()
    
    init(_ request: Request) {
        self.components.host = Constants.Movie.PosterImage.host
        self.components.path = Constants.Movie.PosterImage.path
        self.components.scheme = Constants.scheme
        self.components.queryItems = Constants.imageQueryItems
    }
    
    func url() -> URL? {
        return components.url
    }
    
    func updatePath(_ path: String) {
        self.components.path = path
    }
}
