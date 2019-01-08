//
//  UnboxDataAdapter.swift
//  Tally
//
//  Created by Bruce McTigue on 12/30/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation
import Unbox

extension Movies {
    struct UnboxDataAdapter: MoviesDataAdapterProtocol {
        func itemsFromData(_ data: Data, completionHandler: @escaping (MovieDataAdapter.Result) -> Void) {
            do {
                let moviePage: MoviePage = try unbox(data: data)
                completionHandler(.success(moviePage.results))
            } catch {
                completionHandler(.error(.conversionFailed))
            }
        }
    }
}
