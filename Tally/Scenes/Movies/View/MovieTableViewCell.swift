//
//  MovieTableViewCell.swift
//  Tally
//
//  Created by Bruce McTigue on 1/2/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    typealias ViewModel = Movies.ViewModel
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movieId: Int = 0
    
    var favoriteState: MovieFavoriteState? {
        didSet {
            if let favoriteState = favoriteState {
                self.favoriteStateChanged(favoriteState)
            }
        }
    }
    
    lazy var dynamicFavoriteState: DynamicValue<MovieFavoriteState?> = DynamicValue(favoriteState)
    
    override func awakeFromNib() {
        favoriteButton.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
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
    
    func favoriteStateChanged(_ state: MovieFavoriteState) {
        switch state {
        case .selected(let movieId):
            dynamicFavoriteState.value = .selected(movieId)
            favoriteImageView.image = UIImage(named: "enabled_heart")
            favoriteImageView.tintColor = UIColor.flatRed
        case .unSelected(let movieId):
            dynamicFavoriteState.value = .unSelected(movieId)
            favoriteImageView.image = UIImage(named: "disabled_heart")
            favoriteImageView.tintColor = UIColor.flatGrayDark
        }
    }
}
