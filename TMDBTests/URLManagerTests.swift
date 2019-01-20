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
        let url = urlManager.fetchMoviesURL()
        XCTAssert(url?.path == urlManager.path)
    }
    
    func testFetchMoviesURLWithPage() {
        let urlManager = URLManager()
        let url = urlManager.fetchMoviesURL("1")
        let page = url?.query
        XCTAssert(page!.contains("page=1"))
    }
    
    func testFetchMoviePosterURL() {
        let urlManager = URLManager()
        let url = urlManager.fetchMoviePosterURL("/posterpath")
        XCTAssert(url!.path.contains("posterpath"))
    }
}
