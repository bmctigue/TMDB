//
//  MoviesService.swift
//  TMDB
//
//  Created by Bruce McTigue on 2/11/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation
import Tiguer
import Unbox

extension Movies {
    final class Service<Model: Codable>: Tiguer.Service<Model> {
        override func adaptData(_ data: Data) throws -> [Model] {
            do {
                let results: MovieResults = try unbox(data: data)
                return results.movies.map { $0 as! Model }
            } catch {
                throw DataAdapterError.conversionFailed
            }
        }
    }
}
