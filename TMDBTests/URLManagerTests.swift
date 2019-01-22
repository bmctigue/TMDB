//
//  URLManagerTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 1/9/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB

class URLManagerTests: XCTestCase {

    func testFetchMoviesURL() {
        let urlManager = URLManager()
        let url = urlManager.url()
        XCTAssert(url?.path == Constants.Movie.Data.path)
    }
    
    func testFetchMoviesURLWithPage() {
        let urlManager = URLManager()
        let queryItems = [URLQueryItem(name: "page", value: "1")]
        urlManager.updateQueryItems(queryItems)
        let url = urlManager.url()
        let query = url?.query
        XCTAssert(query!.contains("page=1"))
    }
    
    func testFetchMoviePosterURL() {
        let urlManager = URLManager(host: Constants.Movie.PosterImage.host)
        let path = "\(Constants.Movie.PosterImage.path)/posterpath"
        urlManager.updatePath(path)
        let url = urlManager.url()
        XCTAssert(url!.path.contains("posterpath"))
    }
}
