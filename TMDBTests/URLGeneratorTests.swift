//
//  URLManagerTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 1/9/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB
@testable import Tiguer

class URLGeneratorTests: XCTestCase {

    func testFetchMoviesURL() {
        let urlManager = MoviesDataUrl(Request())
        let url = urlManager.url()
        XCTAssert(url?.path == Constants.Movie.Data.path)
    }
    
    func testFetchMoviesURLWithPage() {
        let request = Request(["page": "1"])
        let urlManager = MoviesDataUrl(request)
        let url = urlManager.url()
        let query = url?.query
        XCTAssert(query!.contains("page=1"))
    }
    
    func testFetchMoviePosterURL() {
        let urlGenerator = MoviesImageUrl(Request())
        let path = "\(Constants.Movie.PosterImage.path)/posterpath"
        urlGenerator.updatePath(path)
        let url = urlGenerator.url()
        XCTAssert(url!.path.contains("posterpath"))
    }
}
