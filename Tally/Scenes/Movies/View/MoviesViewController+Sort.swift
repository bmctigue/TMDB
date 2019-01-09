//
//  MoviesViewController+Sort.swift
//  Tally
//
//  Created by Bruce McTigue on 1/9/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit

extension MoviesViewController {

    @IBAction func sortButtonPressed(_ sender: Any) {
        switch sortState {
        case .none:
            self.sortState = .descending
        case .descending:
            self.sortState = .ascending
        case .ascending:
            self.sortState = .none
        }
        sortStateChanged(sortState)
    }

    func sortStateChanged(_ state: MovieSortState) {
        tableViewController.updateSortState(state)
        switch state {
        case .none:
            sortButton.image = UIImage(named: "Happy_Sad_Face")
        case .descending:
            sortButton.image = UIImage(named: "Happy_Face")
        case .ascending:
            sortButton.image = UIImage(named: "Sad_Face")
        }
    }

}
