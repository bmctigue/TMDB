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
    
    private var tableViewController: MoviesTableViewController
    
    init(with tableViewController: MoviesTableViewController) {
        self.tableViewController = tableViewController
        super.init(nibName: nil, bundle: nil)
        self.title = "Movies"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        add(tableViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyleContrast
    }
}
