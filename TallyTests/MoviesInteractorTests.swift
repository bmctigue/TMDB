//
//  MoviesInteractorTests.swift
//  TallyTests
//
//  Created by Bruce McTigue on 1/4/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import Tally

class MoviesInteractorTests: XCTestCase {
    
    typealias ViewModel = Movies.ViewModel
    
    private lazy var store = LocalStore(Builder.App.moviesAssetName)
    private lazy var dataAdapter = UnboxDataAdapter<Movie>()
    private lazy var service = Service(store, dataAdapter: dataAdapter)
    private lazy var presenter = Movies.Presenter([])
    var viewModels = [ViewModel]()

    func testFetchItemsForAllMovies() {
        let expectation = self.expectation(description: "fetch")
        let presenter = Movies.Presenter([])
        let interactor = Movies.Interactor(service, presenter: presenter, state: .all)
        let dynamicModels = presenter.getDynamicModels()
        dynamicModels.addObserver(self) { [weak self] in
            self?.viewModels = dynamicModels.value
            expectation.fulfill()
        }
        interactor.fetchItems(Request())
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(viewModels.count == 4)
    }
    
    func testFetchItemsForEntree() {
        let expectation = self.expectation(description: "fetch")
        let presenter = Movies.Presenter([])
        let interactor = Movies.Interactor(service, presenter: presenter, state: .wantToSee)
        let dynamicModels = presenter.getDynamicModels()
        dynamicModels.addObserver(self) { [weak self] in
            self?.viewModels = dynamicModels.value
            expectation.fulfill()
        }
        interactor.fetchItems(Request())
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(viewModels.count == 3)
    }
}
