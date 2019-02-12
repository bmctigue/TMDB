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

        private var filterState: MovieFilterState = .all
        private var sortState: MovieSortState = .none
        private lazy var favoritesManager = FavoritesManager()
    
        override var baseViewModels: [ViewModel] {
            var resultModels = [ViewModel]()
            for movieModel in models {
                let model = movieModel as! Movie
                let displayedModel = Movies.ViewModel(movieId: model.movieId, title: model.title, overview: model.overview, releaseDate: model.releaseDate, posterPath: model.posterPath, popularity: model.popularity) as! ViewModel
                resultModels.append(displayedModel)
            }
            return resultModels
        }
        
        override func updatedViewModels(completionHandler: @escaping ([ViewModel]) -> Void) {
            background.dispatch {
                var resultModels = self.viewModels
                
                if self.filterState == .favorite {
                    resultModels = resultModels.filter {
                        let model = $0 as! Movies.ViewModel
                        return self.favoritesManager.getFavorites().contains(model.movieId) }
                }
                
                if self.sortState == .ascending {
                    resultModels = resultModels.sorted (by: {
                        let lhs = $0 as! Movies.ViewModel
                        let rhs = $1 as! Movies.ViewModel
                        return lhs.popularity < rhs.popularity
                        
                    })
                } else if self.sortState == .descending {
                    resultModels = resultModels.sorted (by: {
                        let lhs = $0 as! Movies.ViewModel
                        let rhs = $1 as! Movies.ViewModel
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

extension Movies.Presenter {
    func filterModelsByState(_ state: MovieFilterState) {
        self.filterState = state
        self.updateViewModelsInBackground()
    }
    
    func sortModelsByState(_ state: MovieSortState) {
        self.sortState = state
        self.updateViewModelsInBackground()
    }
    
    func updateFavorites(_ state: MovieFavoriteState) {
        favoritesManager.updateFavorites(state)
    }
    
    func getFavorites() -> Set<Int> {
        return favoritesManager.getFavorites()
    }
}
