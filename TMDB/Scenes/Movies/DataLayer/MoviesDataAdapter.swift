//
//  MoviesDataAdapter.swift
//  TMDB
//
//  Created by Bruce McTigue on 2/27/23.
//  Copyright © 2023 tiguer. All rights reserved.
//

import Foundation
import Tiguer
import Unbox

extension Movies {
    struct MoviesDataAdapter<Model: Codable>: DataAdapterProtocol {
        func adaptData(_ data: Data) throws -> [Model] {
            do {
                let results: MovieResults = try unbox(data: data)
                return results.movies.map { $0 as! Model }
            } catch {
                throw DataAdapterError.conversionFailed
            }
        }
    }
}
