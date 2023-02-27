//
//  MoviesModelFactory.swift
//  TMDB
//
//  Created by Bruce McTigue on 2/11/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation
import Tiguer
import Unbox

extension Movies {
    final class ModelFactory<Model: Codable>: Tiguer.ModelFactory<Model> {}
}
