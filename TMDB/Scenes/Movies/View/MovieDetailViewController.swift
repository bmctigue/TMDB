//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by Bruce McTigue on 4/20/21.
//  Copyright © 2021 tiguer. All rights reserved.
//

import UIKit
import Tiguer

final class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overView: UITextView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var model: Movies.ViewModel
    var presenter: Movies.Presenter<Movie, Movies.ViewModel>
    var movieId: String = ""
    lazy var imageUrlGenerator = MoviesImageUrl(Request())
    
    init(with model: Movies.ViewModel, presenter: Movies.Presenter<Movie, Movies.ViewModel>) {
        self.model = model
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        let path = "\(Constants.Movie.PosterImage.path)\(model.posterPath)"
        self.imageUrlGenerator.updatePath(path)
        let url = self.imageUrlGenerator.url()
        self.cellImageView.kf.setImage(with: url)
        self.movieId = model.selectionId
        self.titleLabel.text = model.title
        self.overView.text = model.overview
        self.releaseDateLabel.text = model.releaseDate
        self.popularityLabel.text = model.formattedPopularity
        self.cellImageView.kf.indicatorType = .activity
        self.title = "Movies"
        cellImageView.layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
