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
        private var store: DataStoreProtocol
        private var dataAdapter: MoviesDataAdapter<Movie>
        private var modelFactory: Movies.ModelFactory<Movie>
        private var presenter: Movies.Presenter<Movie, Movies.ViewModel>
        private var interactor: Movies.Interactor<Movie, Movies.Presenter<Movie, Movies.ViewModel>, Movies.ModelFactory<Movie>>
        private var tableViewController: MoviesTableViewController
        
        init(with title: String, store: DataStoreProtocol, state: MovieFilterState) {
            self.title = title
            self.store = store
            self.state = state
            self.dataAdapter = MoviesDataAdapter<Movie>()
            self.modelFactory = Movies.ModelFactory<Movie>(store, dataAdapter: dataAdapter, cacheKey: Movies.Builder.cacheKey)
            self.presenter = Movies.Presenter<Movie, Movies.ViewModel>()
            self.interactor = Movies.Interactor<Movie, Movies.Presenter, Movies.ModelFactory>(presenter, modelFactory: modelFactory)
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
