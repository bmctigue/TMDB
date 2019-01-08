//
//  MoviesTableViewController.swift
//  Tally
//
//  Created by Bruce McTigue on 1/2/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesTableViewController: UIViewController {
    typealias ViewModel = Movies.ViewModel
    
    let rowHeight: CGFloat = 74.0
    let cellName = "MovieCell"
    let cellNibName = "MovieTableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModels = [ViewModel]()
    var tableViewDatasource: TableViewDataSource<ViewModel>?
    lazy var loadingViewController = LoadingViewController()
    lazy var urlManager = URLManager()
    
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
        
        self.tableViewDatasource = TableViewDataSource(models: viewModels, reuseIdentifier: cellName) { (model: ViewModel, cell: UITableViewCell) in
            let cell = cell as! MovieTableViewCell
            cell.movieId = model.movieId
            cell.titleLabel.text = model.title
            cell.overViewLabel.text = model.overview
            cell.releaseDateLabel.text = model.releaseDate
            self.updateCellImageView(model.posterPath, imageView: cell.cellImageView)
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
            self?.loadingViewController.remove()
        }
        
        add(loadingViewController)
        let request = Request()
        interactor.fetchItems(request)
    }
    
    func updateTableView(_ models: [ViewModel]) {
        self.tableViewDatasource?.models = models
        self.tableView.reloadData {
            self.tableView.scroll(to: .top, animated: true)
        }
    }
    
    func updateFilterState(_ state: MovieFilterState) {
        presenter.filterModelsByState(state)
    }
    
    func updateCellImageView(_ posterPath: String, imageView: UIImageView) {
        var imageView = imageView
        let url = self.urlManager.fetchMoviePosterURL(posterPath)
        let processor = DownsamplingImageProcessor(size: imageView.frame.size)
            >> RoundCornerImageProcessor(cornerRadius: 8)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "movie_poster"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) { _ in
                // noop
            }
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
