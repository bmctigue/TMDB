//
//  MovieTableViewCell.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/2/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit
import Lottie
import Tiguer

class MovieTableViewCell: UITableViewCell {
    typealias ViewModel = Movies.ViewModel
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movieId: String = ""
    
    var favoriteState: SelectionState? {
        didSet {
            if let favoriteState = favoriteState {
                self.favoriteStateChanged(favoriteState)
            }
        }
    }
    
    lazy var dynamicFavoriteState: DynamicValue<SelectionState?> = DynamicValue(favoriteState)
    
    override func awakeFromNib() {
        favoriteImageView.tintColor = MoviesViewController.controlsColor
        cellImageView.layer.cornerRadius = 8
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        if let favoriteState = favoriteState {
            switch favoriteState {
            case .selected:
                self.favoriteState = .unSelected(movieId)
            case .unSelected:
                self.favoriteState = .selected(movieId)
            }
        }
    }
    
    func favoriteStateChanged(_ state: SelectionState) {
        switch state {
        case .selected(let movieId):
            dynamicFavoriteState.value = .selected(movieId)
            favoriteImageView.image = UIImage(named: "minus")
        case .unSelected(let movieId):
            dynamicFavoriteState.value = .unSelected(movieId)
            favoriteImageView.image = UIImage(named: "plus")
        }
    }
}
