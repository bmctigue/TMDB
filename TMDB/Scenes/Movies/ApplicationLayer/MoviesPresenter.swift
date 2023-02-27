//
//  MoviesPresenter.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/31/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Tiguer

extension Movies {
    final class Presenter<Model, ViewModel>: Tiguer.Presenter<Model, ViewModel>, PresenterDecorator {
        
        typealias MovieViewModel = Movies.ViewModel

        public var filterState: MovieFilterState = .all
        public var sortState: MovieSortState = .none
        public let favoritesManager = Movies.SelectionManager<Movie>()
        private var filterDecorator = MovieSelectedFilterDecorator<ViewModel>()
        private var sortDecorator = MoviePopularitySortDecorator<ViewModel>()
        
        override func updateBaseViewModels() {
            var viewModels = [ViewModel]()
            for movieModel in models {
                let model = movieModel as! Movie
                let displayedModel = MovieViewModel(movieId: model.movieId, title: model.title, overview: model.overview, releaseDate: model.releaseDate, posterPath: model.posterPath, popularity: model.popularity) as! ViewModel
                viewModels.append(displayedModel)
            }
            self.baseViewModels = viewModels
        }
        
        override func updateViewModels() {
            filterDecorator.filterState = filterState
            sortDecorator.sortState = sortState
            self.viewModels = baseViewModels
            self.viewModels = filterDecorator.decorate(self.viewModels)
            self.viewModels = sortDecorator.decorate(self.viewModels)
            setDynamicModels(self.viewModels)
        }
    }
}

extension Movies.Presenter {
    func filterModelsByState(_ state: MovieFilterState) {
        self.filterState = state
        self.updateViewModels()
    }
    
    func sortModelsByState(_ state: MovieSortState) {
        self.sortState = state
        self.updateViewModels()
    }
    
    func updateFavorites(_ state: SelectionState) {
        favoritesManager.updateSelections(state)
    }
    
    func getFavorites() -> Set<String> {
        return favoritesManager.getSelections()
    }
    
    func getModels() -> [Model] {
        return self.models
    }
}
