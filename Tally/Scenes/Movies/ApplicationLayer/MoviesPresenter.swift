//
//  MoviesPresenter.swift
//  Tally
//
//  Created by Bruce McTigue on 12/31/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit

extension Movies {
    final class Presenter: PresenterProtocol {
        typealias Model = Movie
        typealias ViewModel = Movies.ViewModel
        private var models: [Model]
        private var dynamicModels: DynamicValue<[ViewModel]> = DynamicValue([ViewModel]())
        private var filterState: MovieFilterState = .all
        private var sortState: MovieSortState = .none
        private lazy var favoritesManager = FavoritesManager()
        
        init(_ models: [Model] = [Model]()) {
            self.models = models
            dynamicModels.value = viewModels
        }
    
        var baseViewModels: [ViewModel] {
            var resultModels = [ViewModel]()
            for model in models {
                let displayedModel = ViewModel(movieId: model.movieId, title: model.title, overview: model.overview, releaseDate: model.releaseDate, posterPath: model.posterPath, popularity: model.popularity)
                resultModels.append(displayedModel)
            }
            return resultModels
        }
        
        var viewModels: [ViewModel] {
            var resultModels = baseViewModels
            
            if filterState == .favorite {
                resultModels = resultModels.filter { favoritesManager.getFavorites().contains($0.movieId) }
            }
            
            if sortState == .ascending {
                resultModels = resultModels.sorted (by: {$0.popularity < $1.popularity})
            } else if sortState == .descending {
                resultModels = resultModels.sorted (by: {$0.popularity > $1.popularity})
            }
            
            return resultModels
        }
        
        func updateViewModels(_ response: Response<Model>) {
            self.models = response.models
            self.dynamicModels.value = viewModels
        }
        
        func filterModelsByState(_ state: MovieFilterState) {
            self.filterState = state
            self.dynamicModels.value = viewModels
        }
    
        func sortModelsByState(_ state: MovieSortState) {
            self.sortState = state
            self.dynamicModels.value = viewModels
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
