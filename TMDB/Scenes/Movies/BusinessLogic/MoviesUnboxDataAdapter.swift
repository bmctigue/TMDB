//
//  UnboxDataAdapter.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/30/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation
import Promis
import Unbox

extension Movies {
    struct UnboxDataAdapter: MoviesDataAdapterProtocol {
        func itemsFromData(_ data: Data) -> Future<MovieDataAdapter.Result> {
            let promise = Promise<MovieDataAdapter.Result>()
            do {
                let moviePage: MoviePage = try unbox(data: data)
                promise.setResult(.success(moviePage.results))
            } catch {
                promise.setError(DataAdapterError.conversionFailed)
            }
            return promise.future
        }
    }
}
