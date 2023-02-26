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
        private var service: Movies.Service<Movie>
        private var presenter: Movies.Presenter<Movie, Movies.ViewModel>
        private var interactor: Movies.Interactor<Movie, Movies.Presenter<Movie, Movies.ViewModel>, Movies.Service<Movie>>
        private var tableViewController: MoviesTableViewController
        
        init(with title: String, store: StoreProtocol, state: MovieFilterState) {
            self.title = title
            self.store = store
            self.state = state
            self.service = Movies.Service<Movie>(store, cacheKey: Movies.Builder.cacheKey)
            self.presenter = Movies.Presenter<Movie, Movies.ViewModel>()
            self.interactor = Movies.Interactor<Movie, Movies.Presenter, Movies.Service>(presenter, service: service)
            self.tableViewController = MoviesTableViewController(with: interactor, presenter: presenter)
        }
        
        func run(completionHandler: VCBuilderBlock) {
            let navigationController = UINavigationController()
            let controller = MoviesViewController(with: tableViewController)
            navigationController.add(controller)
            completionHandler(navigationController)
        }
    }
}
