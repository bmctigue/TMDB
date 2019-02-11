//
//  MoviesService.swift
//  TMDB
//
//  Created by Bruce McTigue on 2/11/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation
import Tiguer

extension Movies {
    final class Service<Model: Codable, Adapter: DataAdapterProtocol>: Tiguer.Service<Model, Adapter> {}
}
