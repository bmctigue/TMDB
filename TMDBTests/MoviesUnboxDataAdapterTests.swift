//
//  UnboxDataAdapterTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/30/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB

class MoviesUnboxDataAdapterTests: XCTestCase {
    
    let assetName = "moviesJson"
    var error: StoreError?
    var items: [Movie] = [Movie]()
    lazy var sut = Movies.UnboxDataAdapter()
    
    override func setUp() {
        items = [Movie]()
    }

    func testAdapter() {
        let expectation = self.expectation(description: "adapter")
        let store = LocalStore(assetName)
        let request = Request()
        
        store.fetchData(request) {[weak self] result in
            switch result {
            case .success(let data):
                self?.sut.itemsFromData(data) { adapterResult in
                    switch adapterResult {
                    case .success(let items):
                        self?.items = items
                    case .error:
                        XCTFail()
                    }
                }
            case .error:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(items.count > 0)
    }
    
    func testAdapterBadData() {
        let expectation = self.expectation(description: "adapter")
        let store = LocalStore("badAssetName")
        let request = Request()
        
        store.fetchData(request) {[weak self] result in
            switch result {
            case .success(let data):
                self?.sut.itemsFromData(data) { adapterResult in
                    switch adapterResult {
                    case .success(let items):
                        self?.items = items
                    case .error:
                        XCTFail()
                    }
                }
            case .error(let error):
                let data = Data()
                self?.sut.itemsFromData(data) { adapterResult in
                    switch adapterResult {
                    case .success(let items):
                        self?.items = items
                    case .error:
                        self?.error = error
                    }
                }
                self?.error = error
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(error)
    }

}
