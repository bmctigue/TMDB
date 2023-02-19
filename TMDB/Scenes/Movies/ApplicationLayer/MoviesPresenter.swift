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
    final class Presenter<Model, ViewModel>: Tiguer.Presenter<Model, ViewModel> {
        
        typealias MovieViewModel = Movies.ViewModel

        private var filterState: MovieFilterState = .all
        private var sortState: MovieSortState = .none
        private lazy var favoritesManager = Movies.SelectionManager<Movie>()
        
        override func updateBaseViewModels() {
            var viewModels = [ViewModel]()
            for movieModel in models {
                let model = movieModel as! Movie
                let displayedModel = MovieViewModel(movieId: model.movieId, title: model.title, overview: model.overview, releaseDate: model.releaseDate, posterPath: model.posterPath, popularity: model.popularity) as! ViewModel
                viewModels.append(displayedModel)
            }
            self.baseViewModels = viewModels
        }
        
        override func filterViewModels(_ viewModels: [ViewModel]) -> [ViewModel] {
            var filteredViewModels = viewModels
            if self.filterState == .favorite {
                filteredViewModels = filteredViewModels.filter {
                    let model = $0 as! MovieViewModel
                    let selections = self.favoritesManager.getSelections()
                    return selections.contains(model.selectionId)
                }
            }
            return filteredViewModels
        }
        
        override func sortViewModels(_ viewModels: [ViewModel]) -> [ViewModel] {
            var sortedViewModels = viewModels
            if self.sortState == .ascending {
                sortedViewModels = sortedViewModels.sorted (by: {
                    let lhs = $0 as! MovieViewModel
                    let rhs = $1 as! MovieViewModel
                    return lhs.popularity < rhs.popularity
                })
            } else if self.sortState == .descending {
                sortedViewModels = sortedViewModels.sorted (by: {
                    let lhs = $0 as! MovieViewModel
                    let rhs = $1 as! MovieViewModel
                    return lhs.popularity > rhs.popularity
                })
            }
            return sortedViewModels
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
}
