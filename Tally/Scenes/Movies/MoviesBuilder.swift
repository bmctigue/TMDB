//
//  MoviesBuilder.swift
//  Tally
//
//  Created by Bruce McTigue on 12/25/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit

enum Movies {
    final class Builder: VCBuilder {
        
        static let moviesAssetName = "moviesJson"
        static let moviesTitle = "Movies"
        
        private var title: String
        
        private var state: MovieFilterState
        private var store: StoreProtocol
        private lazy var dataAdapter = Movies.UnboxDataAdapter()
        private lazy var service = Service(store, dataAdapter: dataAdapter)
        private lazy var presenter = Movies.Presenter([])
        private lazy var interactor = Movies.Interactor(service, presenter: presenter)
        private lazy var tableViewController = MoviesTableViewController(with: interactor, presenter: presenter)
        
        init(with title: String, store: StoreProtocol, state: MovieFilterState) {
            self.title = title
            self.store = store
            self.state = state
        }
        
        func run(completionHandler: VCBuilderBlock) {
            let navigationController = UINavigationController()
            let controller = MoviesViewController(with: tableViewController)
            navigationController.add(controller)
            completionHandler(navigationController)
        }
    }
}
