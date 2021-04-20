//
//  MoviesViewController.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/25/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Tiguer

final class MoviesViewController: UIViewController {
    
    static let controlsColor = UIColor.red
    static let happySadFace = "happy_sad_face"
    
    lazy var favoritesButton = UIBarButtonItem(title: "My List", style: .plain, target: self, action: #selector(favoritesButtonPressed(_:)))
    
    lazy var sortButton = UIBarButtonItem(image: UIImage(named: MoviesViewController.happySadFace), style: .plain, target: self, action: #selector(sortButtonPressed(_:)))
    
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
        self.tableViewController.tableViewDelegate = self
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = UIColor.lightGray
        favoritesButton.tintColor = MoviesViewController.controlsColor
        sortButton.tintColor = MoviesViewController.controlsColor
        self.navigationItem.rightBarButtonItem = favoritesButton
        self.navigationItem.leftBarButtonItem = sortButton
        sortButton.image = UIImage(named: MoviesViewController.happySadFace)
        add(tableViewController)
    }
    
    func showDetailView(model: Movies.ViewModel) {
        let controller = MovieDetailViewController(with: model, presenter: tableViewController.presenter)
        show(controller, sender: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
