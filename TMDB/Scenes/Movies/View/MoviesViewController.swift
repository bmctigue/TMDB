//
//  MoviesViewController.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/25/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import ChameleonFramework

final class MoviesViewController: UIViewController {
    
    static let controlsColor = UIColor.flatRedDark
    
    lazy var favoritesButton = UIBarButtonItem(title: "My List", style: .plain, target: self, action: #selector(favoritesButtonPressed(_:)))
    
    lazy var sortButton = UIBarButtonItem(image: UIImage(named: "Happy_Sad_Face"), style: .plain, target: self, action: #selector(sortButtonPressed(_:)))
    
    var filterState: MovieFilterState = .all
    var sortState: MovieSortState = .none
    var tableViewController: MoviesTableViewController
    
    init(with tableViewController: MoviesTableViewController) {
        self.tableViewController = tableViewController
        super.init(nibName: nil, bundle: nil)
        self.title = "Movies"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        favoritesButton.tintColor = MoviesViewController.controlsColor
        sortButton.tintColor = MoviesViewController.controlsColor
        self.navigationItem.rightBarButtonItem = favoritesButton
        self.navigationItem.leftBarButtonItem = sortButton
        filterStateChanged(filterState)
        sortStateChanged(sortState)
        add(tableViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
