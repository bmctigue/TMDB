//
//  FavoritesManager.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit
import Tiguer

extension Movies {
    final class FavoritesManager {
        
        typealias Model = Movie
        typealias ViewModel = Movies.ViewModel
        let favoritesKey = "favorites"
        
        private var favorites: Set<Int> = []
        private lazy var cache = BaseCache<Set<Int>>()
        
        init() {
            self.favorites = cache.getObject(favoritesKey) ?? []
        }
        
        func updateFavorites(_ state: MovieFavoriteState) {
            switch state {
            case .selected(let movieId):
                favorites.insert(movieId)
            case .unSelected(let movieId):
                favorites.remove(movieId)
            }
            cache.setObject(favorites, key: favoritesKey)
        }
        
        func getFavorites() -> Set<Int> {
            return favorites
        }
        
    }
}
