//
//  MoviesViewController+Filter.swift
//  Tally
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
    
    func filterStateChanged(_ state: MovieFilterState) {
        tableViewController.updateFilterState(state)
        switch state {
        case .all:
            favoritesButton.image = UIImage(named: "enabled_heart")
            favoritesButton.tintColor = .red
        case .favorite:
            favoritesButton.image = UIImage(named: "disabled_heart")
            favoritesButton.tintColor = .red
        }
    }
}
