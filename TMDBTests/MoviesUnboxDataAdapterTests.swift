//
//  UnboxDataAdapterTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/30/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
import Promis
@testable import TMDB

class MoviesUnboxDataAdapterTests: XCTestCase {
    
    let assetName = "moviesJson"
    var items: [Movie] = [Movie]()
    lazy var sut = Movies.UnboxDataAdapter<Movie>()
    
    override func setUp() {
        items = [Movie]()
    }

    func testAdapter() {
        let expectation = self.expectation(description: "adapter")
        if let asset = NSDataAsset(name: assetName, bundle: Bundle.main) {
            sut.itemsFromData(asset.data).finally(queue: .main) { future in
                switch future.state {
                case .result(let adapterResult):
                    switch adapterResult {
                    case .success(let items):
                        self.items = items
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
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(items.count > 0)
    }
}
