//
//  MoviesTableViewController.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/2/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit
import Kingfisher
import UIEmptyState
import Tiguer

final class MoviesTableViewController: UIViewController {
    typealias ViewModel = Movies.ViewModel
    
    private static let rowHeight: CGFloat = 126.0
    static let cellName = "MovieCell"
    static let cellNibName = "MovieTableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModels = [ViewModel]()
    var tableViewDatasource: TableViewDataSource<ViewModel>?
    private lazy var loadingViewController = LoadingViewController()
    private lazy var refreshControl = UIRefreshControl()
    
    private let interactor: InteractorProtocol
    let presenter: Movies.Presenter<Movie, ViewModel>
    
    init(with interactor: InteractorProtocol, presenter: Movies.Presenter<Movie, ViewModel>) {
        self.interactor = interactor
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = MoviesTableViewController.rowHeight
        self.tableView.register(UINib(nibName: MoviesTableViewController.cellNibName, bundle: nil), forCellReuseIdentifier: MoviesTableViewController.cellName)
        self.emptyStateDataSource = self
        self.emptyStateDelegate = self
        
        self.addDataSource()
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        let dynamicModels = presenter.getDynamicModels()
        dynamicModels.addObserver(self) { [weak self] in
            self?.updateTableView(dynamicModels.value)
            self?.refreshControl.endRefreshing()
            self?.loadingViewController.remove()
        }
        
        add(loadingViewController)
        let request = Request()
        fetchItems(request: request)
    }
    
    @objc func refreshTableView() {
        let params = [Tiguer.Constants.forceKey: "true"]
        let request = Request(params)
        fetchItems(request: request)
    }
    
    func fetchItems(request: Request) {
        let urlGenerator = MoviesDataUrl(request)
        if let url = urlGenerator.url() {
            interactor.fetchItems(request, url: url)
        }
    }
    
    func updateTableView(_ models: [ViewModel]) {
        self.tableViewDatasource?.models = models
        self.tableView.reloadData {
            self.tableView.scroll(to: .top, animated: true)
            self.reloadEmptyStateForTableView(self.tableView)
        }
    }
    
    func updateFilterState(_ state: MovieFilterState) {
        presenter.filterModelsByState(state)
    }
    
    func updateSortState(_ state: MovieSortState) {
        presenter.sortModelsByState(state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

extension MoviesTableViewController: UIEmptyStateDelegate, UIEmptyStateDataSource {
    
    var emptyStateTitle: NSAttributedString {
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor.red,
                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        return NSAttributedString(string: "Sorry, no favorites!", attributes: attrs)
    }
}
