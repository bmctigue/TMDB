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
    
    private lazy var store = LocalStore(Movies.Builder.moviesAssetName)
    private lazy var dataAdapter = Movies.UnboxDataAdapter()
    private lazy var service = Movies.Service(store, dataAdapter: dataAdapter)
    private lazy var presenter = Movies.Presenter([])
    var viewModels = [ViewModel]()
    
    let background = SyncQueue.background
    let main = SyncQueue.global

    func testFetchItemsForAllMovies() {
        let presenter = Movies.Presenter()
        presenter.main = main
        presenter.background = background
        let sut = Movies.Interactor(service, presenter: presenter)
        sut.fetchItems(Request())
        let dynamicModels = presenter.getDynamicModels()
        XCTAssertNotNil(dynamicModels.value.count == 4)
    }
}
