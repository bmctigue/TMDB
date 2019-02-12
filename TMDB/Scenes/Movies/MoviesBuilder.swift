//
//  MoviesBuilder.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/25/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Tiguer

enum Movies {
    final class Builder: VCBuilder {
        
        static let moviesAssetName = "moviesJson"
        static let moviesTitle = "Movies"
        static let cacheKey = "movies"
        
        private var title: String
        
        private var state: MovieFilterState
        private var store: StoreProtocol
        private lazy var dataAdapter = Movies.UnboxDataAdapter()
        private lazy var service = Movies.Service<Movie, UnboxDataAdapter>(store, dataAdapter: dataAdapter, cacheKey: Movies.Builder.cacheKey)
        private lazy var presenter = Movies.Presenter<Movie, Movies.ViewModel>([])
        private lazy var interactor = Movies.Interactor<Movie, Movies.Presenter, Movies.Service>(presenter, service: service)
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
