//
//  MoviesTableViewController+DataSource.swift
//  TMDB
//
//  Created by Bruce McTigue on 2/26/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit
import Tiguer

extension MoviesTableViewController {
    func addDataSource() {
        self.tableViewDatasource = TableViewDataSource(models: viewModels, reuseIdentifier: MoviesTableViewController.cellName) { (model: ViewModel, cell: UITableViewCell) in
            var model = model
            let cell = cell as! MovieTableViewCell
            cell.model = model
            cell.movieId = model.selectionId
            cell.titleLabel.text = model.title
            cell.overViewLabel.text = model.overview
            cell.releaseDateLabel.text = model.releaseDate
            cell.popularityLabel.text = model.formattedPopularity
            cell.cellImageView.kf.indicatorType = .activity
            cell.cellImageView.kf.setImage(with: model.postPathUrl())
            cell.favoriteState = self.presenter.getFavorites().contains(model.selectionId) ? SelectionState.selected(model.selectionId) : SelectionState.unSelected(model.selectionId)
            cell.dynamicFavoriteState.addObserver(self) {
                if let state = cell.dynamicFavoriteState.value {
                    self.presenter.updateFavorites(state)
                }
            }
            cell.tableViewDelegate = self.tableViewDelegate
        }
        self.tableView.dataSource = tableViewDatasource
    }
}
