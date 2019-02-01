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
import Tiguer

extension Movies {
    struct UnboxDataAdapter: DataAdapterProtocol {
        typealias Model = Movie
        func itemsFromData(_ data: Data) -> Future<DataAdapter.Result<Movie>> {
            let promise = Promise<DataAdapter.Result<Movie>>()
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
