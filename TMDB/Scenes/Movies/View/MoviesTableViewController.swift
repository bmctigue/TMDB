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

class MoviesTableViewController: UIViewController {
    typealias ViewModel = Movies.ViewModel
    
    let rowHeight: CGFloat = 126.0
    let cellName = "MovieCell"
    let cellNibName = "MovieTableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModels = [ViewModel]()
    var tableViewDatasource: TableViewDataSource<ViewModel>?
    lazy var loadingViewController = LoadingViewController()
    lazy var refreshControl = UIRefreshControl()
    lazy var imageUrlGenerator = MoviesImageUrl(Request())
    
    private var interactor: InteractorProtocol
    private var presenter: Movies.Presenter
    
    init(with interactor: InteractorProtocol, presenter: Movies.Presenter) {
        self.interactor = interactor
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = rowHeight
        self.tableView.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellName)
        self.emptyStateDataSource = self
        self.emptyStateDelegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        self.tableViewDatasource = TableViewDataSource(models: viewModels, reuseIdentifier: cellName) { (model: ViewModel, cell: UITableViewCell) in
            let cell = cell as! MovieTableViewCell
            cell.movieId = model.movieId
            cell.titleLabel.text = model.title
            cell.overViewLabel.text = model.overview
            cell.releaseDateLabel.text = model.releaseDate
            cell.popularityLabel.text = model.formattedPopularity
            cell.cellImageView.kf.indicatorType = .activity
            if model.posterPath.isEmpty {
                cell.cellImageView.kf.setImage(with: nil as Resource?)
            } else {
                let path = "\(Constants.Movie.PosterImage.path)\(model.posterPath)"
                self.imageUrlGenerator.updatePath(path)
                let imageUrl = self.imageUrlGenerator.url()
                cell.cellImageView.kf.setImage(with: imageUrl)
            }
            cell.favoriteState = self.presenter.getFavorites().contains(model.movieId) ? MovieFavoriteState.selected(model.movieId) : MovieFavoriteState.unSelected(model.movieId)
            cell.dynamicFavoriteState.addObserver(self) {
                if let state = cell.dynamicFavoriteState.value {
                    self.presenter.updateFavorites(state)
                }
            }
        }
        self.tableView.dataSource = tableViewDatasource
        
        let dynamicModels = presenter.getDynamicModels()
        dynamicModels.addObserver(self) { [weak self] in
            self?.updateTableView(dynamicModels.value)
            self?.refreshControl.endRefreshing()
            self?.loadingViewController.remove()
        }
        
        add(loadingViewController)
        let request = Request()
        interactor.fetchItems(request)
    }
    
    @objc func refreshTableView() {
        let params = [Constants.forceKey: "true"]
        let request = Request(params)
        interactor.fetchItems(request)
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
