//
//  MovieStoreTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB

class LocalStoreTests: XCTestCase {
    
    let assetName = "moviesJson"
    var fetchedData: Data?
    var error: StoreError?
    
    func testLocalStore() {
        let expectation = self.expectation(description: "fetchData")
        let sut = LocalStore(assetName)
        let request = Request()
        sut.fetchData(request, url: nil).finally { future in
            switch future.state {
            case .result(let storeResult):
                switch storeResult {
                case .success(let data):
                    self.fetchedData = data
                case .error(let error):
                    print(error)
                    XCTFail()
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
        XCTAssertNotNil(fetchedData)
    }

    func testLocalStoreBadAsset() {
        let expectation = self.expectation(description: "fetchData")
        let sut = LocalStore("badAssetName")
        let request = Request()
        sut.fetchData(request, url: nil).finally { future in
            switch future.state {
            case .result(let storeResult):
                switch storeResult {
                case .success(let data):
                    self.fetchedData = data
                case .error(let error):
                    XCTFail()
                }
            case .error(let error):
                print(error.localizedDescription)
                self.error = error as? StoreError
            case .cancelled:
                XCTFail()
            case .unresolved:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(error)
    }
}
