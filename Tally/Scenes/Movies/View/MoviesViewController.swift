//
//  MoviesViewController.swift
//  Tally
//
//  Created by Bruce McTigue on 12/25/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import ChameleonFramework

final class MoviesViewController: UIViewController {
    
    lazy var favoritesButton = UIBarButtonItem(image: UIImage(named: "enabled_heart"), style: .plain, target: self, action: #selector(favoritesButtonPressed(_:)))
    
    private var state: MovieFilterState
    private var tableViewController: MoviesTableViewController
    
    init(with tableViewController: MoviesTableViewController) {
        self.tableViewController = tableViewController
        self.state = .all
        super.init(nibName: nil, bundle: nil)
        self.title = "Movies"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.navigationItem.rightBarButtonItem = favoritesButton
        filterStateChanged(state)
        add(tableViewController)
    }
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        self.state = state == .all ? .favorite : .all
        filterStateChanged(state)
    }
    
    func filterStateChanged(_ state: MovieFilterState) {
        tableViewController.updateFilterState(state)
        switch state {
        case .all:
            favoritesButton.image = UIImage(named: "enabled_heart")
            favoritesButton.tintColor = .flatRed
        case .favorite:
            favoritesButton.image = UIImage(named: "disabled_heart")
            favoritesButton.tintColor = .flatRed
        }
    }
    
    func updateFilteredMovies() {
        self.tableViewController.updateFilterState(state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyleContrast
    }
}
