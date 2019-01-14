//
//  MoviesStoreTests.swift
//  TallyTests
//
//  Created by Bruce McTigue on 1/14/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import Tally

class MoviesStoreTests: XCTestCase {

    var initialData = Data(bytes: [0, 1, 0, 1])
    var resultData: Data?
    var error: StoreError?
    let session = MockNetworkSession()
    let url = URL(string: "https://www.google.com")!
    
    func testMoviesStoreFetchData() {
        let expectation = self.expectation(description: "fetchData")
        session.data = initialData
        let store = Movies.RemoteStore(session: session)
        let request = Request([:])
        
        store.fetchData(request, url: url) { [weak self] result in
            switch result {
            case .success(let data):
                self?.resultData = data
            case .error:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(resultData?.count == initialData.count)
    }
    
    func testMoviesStoreFetchDataNilURL() {
        let expectation = self.expectation(description: "fetchData")
        session.data = initialData
        let store = Movies.RemoteStore(session: session)
        let request = Request([:])
        
        store.fetchData(request, url: nil) { [weak self] result in
            switch result {
            case .success(let data):
                self?.resultData = data
            case .error:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(resultData?.count == 0)
    }
}
