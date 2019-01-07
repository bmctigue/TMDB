//
//  Movie.swift
//  Tally
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Unbox

enum MovieType: Int, UnboxableEnum {
    case movie
}

struct Movie {
    var movieId: String
    var name: String
    var text: String
    var price: String
    var type: MovieType
    var imageUrl: String
    var image: String
    var wantToSee: Bool
}

extension Movie: Unboxable {
    init(unboxer: Unboxer) throws {
        self.movieId = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
        self.text = try unboxer.unbox(key: "text")
        self.price = try unboxer.unbox(key: "price")
        self.type = try unboxer.unbox(key: "type")
        self.imageUrl = try unboxer.unbox(key: "image_url")
        self.image = try unboxer.unbox(key: "image")
        self.wantToSee = false
    }
}
