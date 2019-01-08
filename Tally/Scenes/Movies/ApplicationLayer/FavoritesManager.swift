//
//  FavoritesManager.swift
//  Tally
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit
import Cache

extension Movies {
    struct FavoritesManager {
        
        typealias Model = Movie
        typealias ViewModel = Movies.ViewModel
        let favoritesKey = "favorites"
        
        private var favorites: Set<Int> = []
        private var favoritesCache = FavoritesCache()
        
        init() {
            self.favorites = favoritesCache.getObject(favoritesKey) ?? []
        }
        
        mutating func updateFavorites(_ state: MovieFavoriteState) {
            switch state {
            case .selected(let movieId):
                favorites.insert(movieId)
            case .unSelected(let movieId):
                favorites.remove(movieId)
            }
            favoritesCache.setObject(favorites, key: favoritesKey)
        }
        
        func filterModelsByState(_ models: [Model], state: MovieFilterState) -> Response<Model> {
            switch state {
            case .all:
                return Response(models: models)
            case .favorite:
                let filteredModels = models.filter { favorites.contains($0.movieId) }
                return Response(models: filteredModels)
            }
        }
        
        func getFavorites() -> Set<Int> {
            return favorites
        }
        
    }
}
