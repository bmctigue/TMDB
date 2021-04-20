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
    final class UnboxDataAdapter<Model>: Tiguer.DataAdapter<Model> {
        
        override func itemsFromData(_ data: Data) -> Future<DataAdapterResult.Result<Model>> {
            let promise = Promise<DataAdapterResult.Result<Model>>()
            do {
                let results: MovieResults = try unbox(data: data)
                let models = results.movies.map { $0 as! Model }
                promise.setResult(DataAdapterResult.Result.success(models))
            } catch {
                promise.setError(DataAdapterError.conversionFailed)
            }
            return promise.future
        }
    }
}
