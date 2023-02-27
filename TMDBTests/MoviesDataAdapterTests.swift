//
//  MoviesDataAdapterTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 2/27/23.
//  Copyright © 2023 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB
@testable import Tiguer

final class MoviesDataAdapterTests: XCTestCase {
    
    func testAdaptData() {
        let dataAdapter = Movies.MoviesDataAdapter<Movie>()
        do {
            _ = try dataAdapter.adaptData(Data())
            XCTFail()
        } catch {
            XCTAssert(true)
        }
    }
}
