//
//  MoviesViewController+Filter.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/9/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit

extension MoviesViewController {
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        self.filterState = filterState == .all ? .favorite : .all
        filterStateChanged(filterState)
    }
    
    func refreshFavorites() {
        filterStateChanged(.favorite)
    }
    
    func filterStateChanged(_ state: MovieFilterState) {
        tableViewController.updateFilterState(state)
        switch state {
        case .all:
            favoritesButton.title = "My List"
        case .favorite:
            favoritesButton.title = "All"
        }
    }
}
