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
    final class Presenter: PresenterProtocol {
        typealias Model = Movie
        typealias ViewModel = Movies.ViewModel
        private var models: [Model]
        private var viewModels: [ViewModel] = []
        private var dynamicModels: DynamicValue<[ViewModel]> = DynamicValue([ViewModel]())
        private var filterState: MovieFilterState = .all
        private var sortState: MovieSortState = .none
        private lazy var favoritesManager = FavoritesManager()
        
        private var main: Dispatching
        private var background: Dispatching
        
        init(_ models: [Model] = [Model](), main: Dispatching = AsyncQueue.main, background: Dispatching = AsyncQueue.background) {
            self.models = models
            self.main = main
            self.background = background
            self.viewModels = baseViewModels
            self.updateViewModelsInBackground()
        }
    
        private var baseViewModels: [ViewModel] {
            var resultModels = [ViewModel]()
            for model in models {
                let displayedModel = ViewModel(movieId: model.movieId, title: model.title, overview: model.overview, releaseDate: model.releaseDate, posterPath: model.posterPath, popularity: model.popularity)
                resultModels.append(displayedModel)
            }
            return resultModels
        }
        
        private func updatedViewModels(completionHandler: @escaping ([ViewModel]) -> Void) {
            background.dispatch {
                var resultModels = self.viewModels
                
                if self.filterState == .favorite {
                    resultModels = resultModels.filter { self.favoritesManager.getFavorites().contains($0.movieId) }
                }
                
                if self.sortState == .ascending {
                    resultModels = resultModels.sorted (by: {$0.popularity < $1.popularity})
                } else if self.sortState == .descending {
                    resultModels = resultModels.sorted (by: {$0.popularity > $1.popularity})
                }
                
                self.main.dispatch {
                    completionHandler(resultModels)
                }
            }
        }
        
        func updateViewModels(_ response: Response<Model>) {
            self.models = response.models
            self.viewModels = baseViewModels
            self.updateViewModelsInBackground()
        }
        
        func filterModelsByState(_ state: MovieFilterState) {
            self.filterState = state
            self.updateViewModelsInBackground()
        }
    
        func sortModelsByState(_ state: MovieSortState) {
            self.sortState = state
            self.updateViewModelsInBackground()
        }
        
        func updateViewModelsInBackground() {
            updatedViewModels { [weak self] results in
                self?.dynamicModels.value = results
            }
        }
        
        func getDynamicModels() -> DynamicValue<[ViewModel]> {
            return dynamicModels
        }
        
        func getModels() -> [Model] {
            return models
        }
        
        func updateFavorites(_ state: MovieFavoriteState) {
            favoritesManager.updateFavorites(state)
        }
        
        func getFavorites() -> Set<Int> {
            return favoritesManager.getFavorites()
        }
    }
}
