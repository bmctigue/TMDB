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
    
        override var baseViewModels: [ViewModel] {
            var resultModels = [ViewModel]()
            for movieModel in models {
                let model = movieModel as! Movie
                let displayedModel = MovieViewModel(movieId: model.movieId, title: model.title, overview: model.overview, releaseDate: model.releaseDate, posterPath: model.posterPath, popularity: model.popularity) as! ViewModel
                resultModels.append(displayedModel)
            }
            return resultModels
        }
        
        override func updatedViewModels(completionHandler: @escaping ([ViewModel]) -> Void) {
            background.dispatch { [weak self] in
                if let self = self {
                    var resultModels = self.viewModels
                    
                    if self.filterState == .favorite {
                        resultModels = resultModels.filter {
                            let model = $0 as! MovieViewModel
                            return self.favoritesManager.getSelections().contains(model.selectionId)
                        }
                    }
                    
                    if self.sortState == .ascending {
                        resultModels = resultModels.sorted (by: {
                            let lhs = $0 as! MovieViewModel
                            let rhs = $1 as! MovieViewModel
                            return lhs.popularity < rhs.popularity
                        })
                    } else if self.sortState == .descending {
                        resultModels = resultModels.sorted (by: {
                            let lhs = $0 as! MovieViewModel
                            let rhs = $1 as! MovieViewModel
                            return lhs.popularity > rhs.popularity
                        })
                    }
                    
                    self.main.dispatch {
                        completionHandler(resultModels)
                    }
                }
            }
        }
    }
}

extension Movies.Presenter {
    func filterModelsByState(_ state: MovieFilterState) {
        self.filterState = state
        self.updateViewModelsInBackground()
    }
    
    func sortModelsByState(_ state: MovieSortState) {
        self.sortState = state
        self.updateViewModelsInBackground()
    }
    
    func updateFavorites(_ state: SelectionState) {
        favoritesManager.updateSelections(state)
    }
    
    func getFavorites() -> Set<String> {
        return favoritesManager.getSelections()
    }
}
