//
//  MovieStoreTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import Tiguer

class LocalStoreTests: XCTestCase {
    
    let assetName = "moviesJson"
    let url = URL(string: "https://www.google.com")
    var fetchedData: Data?
    var error: StoreError?
    
    func testLocalStore() {
        let expectation = self.expectation(description: "fetchData")
        let sut = LocalStore(assetName)
        sut.fetchData(url!).finally { future in
            switch future.state {
            case .result(let storeResult):
                switch storeResult {
                case .success(let data):
                    self.fetchedData = data
                }
            case .error(let error):
                print(error)
            case .cancelled:
                print("cancelled")
            case .unresolved:
                print("unresolved")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(fetchedData)
        XCTAssertNil(error)
    }

    func testLocalStoreBadAsset() {
        let expectation = self.expectation(description: "fetchData")
        let sut = LocalStore("badAssetName")
        self.fetchedData = nil
        sut.fetchData(url!).finally { future in
            switch future.state {
            case .result(let storeResult):
                switch storeResult {
                case .success(let data):
                    self.fetchedData = data
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
        XCTAssertNil(fetchedData)
    }
}
