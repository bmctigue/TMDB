//
//  MoviesStoreTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 1/14/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
import Promis
@testable import TMDB

class MoviesStoreTests: XCTestCase {
    
    let movie1 = Movie(voteCount: 0, movieId: 1, video: false, voteAverage: 1, title: "test", popularity: 50, posterPath: "", originalLanguage: "en", originalTitle: "test", genreIds: [0], backdropPath: "", adult: false, overview: "test", releaseDate: "11-03-18")
    
    let movie2 = Movie(voteCount: 0, movieId: 2, video: false, voteAverage: 1, title: "test", popularity: 100, posterPath: "", originalLanguage: "en", originalTitle: "test", genreIds: [0], backdropPath: "", adult: false, overview: "test", releaseDate: "11-03-18")

    var initialData: Data!
    var fetchedData: Data?
    var error: StoreError?
    let url = URL(string: "https://www.google.com")!
    lazy var request = Request([:])
    lazy var config = URLSessionConfiguration.ephemeral
    var session: URLSession!
    var sut: StoreProtocol!
    
    override func setUp() {
        self.initialData = try? JSONEncoder().encode([movie1, movie2])
        URLProtocolStub.testURLs = [url: initialData!]
        config.protocolClasses = [URLProtocolStub.self]
        self.session = URLSession(configuration: config)
        self.sut = Movies.RemoteStore(session: session)
    }
    
    func testMoviesStoreFetchData() {
        let expectation = self.expectation(description: "fetchData")
        sut.fetchData(request, url: url).finally { future in
            switch future.state {
            case .result(let storeResult):
                switch storeResult {
                case .success(let data):
                    self.fetchedData = data
                }
            case .error(let error):
                print(error)
                XCTFail()
            case .cancelled:
                XCTFail()
            case .unresolved:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(fetchedData?.count == initialData.count)
        XCTAssertNil(error)
    }

    func testMoviesStoreFetchDataNilURL() {
        let expectation = self.expectation(description: "fetchData")
        sut.fetchData(request, url: nil).finally { future in
            switch future.state {
            case .result(let storeResult):
                switch storeResult {
                case .success(let data):
                    self.fetchedData = data
                }
            case .error(let error):
                print(error)
                XCTFail()
            case .cancelled:
                XCTFail()
            case .unresolved:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(fetchedData?.count == 0)
        XCTAssertNil(error)
    }
}
