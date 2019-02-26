//
//  MovieTableViewCellTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
import Tiguer
@testable import TMDB

class MovieTableViewCellTests: XCTestCase {
    
    private var cell: MovieTableViewCell?
    var newState = SelectionState.unSelected("0")
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle.main
        let nib = bundle.loadNibNamed("MovieTableViewCell", owner: nil, options: nil)
        cell = nib?.first as? MovieTableViewCell
    }
    
    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testFavoriteStateChanged() {
        cell?.favoriteState = .selected("0")
        
        cell?.favoriteButtonPressed(UIButton())
        XCTAssert(cell?.favoriteState! == SelectionState.unSelected(""))
        
        cell?.favoriteButtonPressed(UIButton())
        XCTAssert(cell?.favoriteState! == SelectionState.selected(""))
    }
    
    func testDynamicFavoriteStateChanged() {
        let expectation = self.expectation(description: "addObserver")
        if let cell = cell {
            cell.favoriteState = newState
            cell.dynamicFavoriteState.addObserver(self) { [weak self] in
                self?.newState = (cell.dynamicFavoriteState.value)!
                expectation.fulfill()
            }
            cell.favoriteState = .selected("0")
            waitForExpectations(timeout: 3.0, handler: nil)
            XCTAssert(self.newState == .selected("0"))
        } else {
            XCTFail()
        }
    }

}
