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
    
    var favorite: Bool? {
        didSet {
            if let favorite = favorite {
                if favorite {
                    favoriteImageView.image = UIImage(named: "enabled_heart")
                    favoriteImageView.tintColor = UIColor.flatRed
                } else {
                    favoriteImageView.image = UIImage(named: "disabled_heart")
                    favoriteImageView.tintColor = UIColor.flatWhite
                }
            }
        }
    }
    
    override func awakeFromNib() {
        favoriteButton.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        cellImageView.layer.cornerRadius = 8
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        if let favorite = favorite {
            self.favorite = !favorite
        }
    }
}
