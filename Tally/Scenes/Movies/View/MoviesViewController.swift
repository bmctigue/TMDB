//
//  MoviesViewController.swift
//  Tally
//
//  Created by Bruce McTigue on 12/25/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {
    
    lazy var favoritesButton = UIBarButtonItem(image: UIImage(named: "enabled_heart"), style: .plain, target: self, action: #selector(favoritesButtonPressed(_:)))
    
    var state: MovieFilterState = .all
    var tableViewController: MoviesTableViewController
    
    init(with tableViewController: MoviesTableViewController) {
        self.tableViewController = tableViewController
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
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
