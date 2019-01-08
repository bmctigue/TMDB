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
    
    override func layoutSubviews() {
        cellImageView.layer.cornerRadius = 8
    }
}
