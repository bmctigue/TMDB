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
        private var filterState: MovieFilterState
        private var favoritesManager = FavoritesManager()
        
        init(_ models: [Model] = [Model]()) {
            self.models = models
            self.filterState = .all
            dynamicModels.value = viewModels
        }
    
        var baseViewModels: [ViewModel] {
            var resultModels = [ViewModel]()
            for model in models {
                let displayedModel = ViewModel(movieId: model.movieId, title: model.title, overview: model.overview, releaseDate: model.releaseDate, posterPath: model.posterPath)
                resultModels.append(displayedModel)
            }
            return resultModels
        }
        
        var viewModels: [ViewModel] {
            var resultModels = baseViewModels
            if filterState == .favorite {
                resultModels = resultModels.filter { favoritesManager.getFavorites().contains($0.movieId) }
            }
            return resultModels
        }
        
        func updateViewModels(_ response: Response<Model>) {
            self.models = response.models
            self.dynamicModels.value = baseViewModels
        }
        
        func filterModelsByState(_ state: MovieFilterState) {
            self.filterState = state
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
