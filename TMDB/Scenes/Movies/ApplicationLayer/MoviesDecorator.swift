//
//  MoviesDecorator.swift
//  TMDB
//
//  Created by Bruce McTigue on 2/26/23.
//  Copyright © 2023 tiguer. All rights reserved.
//

import Foundation
import Tiguer

extension Movies {
    
    public struct MovieSelectedFilterDecorator<ViewModel>: Decorator {
        
        typealias MovieViewModel = Movies.ViewModel
        public var filterState: MovieFilterState = .all
        
        func decorate(_ viewModels: [ViewModel]) -> [ViewModel] {
            let favoritesManager = Movies.SelectionManager<Movie>()
            var filteredViewModels = viewModels
            if self.filterState == .favorite {
                filteredViewModels = filteredViewModels.filter {
                    let model = $0 as! MovieViewModel
                    let selections = favoritesManager.getSelections()
                    return selections.contains(model.selectionId)
                }
            }
            return filteredViewModels
        }
    }
    
    public struct MoviePopularitySortDecorator<ViewModel>: Decorator {
        
        typealias MovieViewModel = Movies.ViewModel
        public var sortState: MovieSortState = .none
        
        func decorate(_ viewModels: [ViewModel]) -> [ViewModel] {
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
