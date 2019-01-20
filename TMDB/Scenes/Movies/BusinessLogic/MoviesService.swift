//
//  MoviesService.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Promis

extension Movies {
    final class Service<Adapter: MoviesDataAdapterProtocol>: ServiceProtocol {
        
        private var store: StoreProtocol
        private var dataAdapter: Adapter
        private var movies: [Movie] = []
        lazy var moviesCache = MoviesCache(AppStateManager.shared)
        lazy var urlManager = URLManager()
        
        let moviesKey = "movies"
        
        init(_ store: StoreProtocol, dataAdapter: Adapter) {
            self.store = store
            self.dataAdapter = dataAdapter
            self.movies = moviesCache.getObject(moviesKey) ?? []
        }
        
        func fetchItems(_ request: Request, completionHandler: @escaping ([Any]) -> Void) {
            let force = request.params["force"]
            if movies.isEmpty || force != nil {
                let page = request.params["page"] ?? "1"
                let url = urlManager.fetchMoviesURL(page)
                
                store.fetchData(request, url: url).thenWithResult { [weak self] (storeResult: Store.Result) -> Future<MovieDataAdapter.Result> in
                    switch storeResult {
                    case .success(let data):
                        return (self!.dataAdapter.itemsFromData(data))
                    case .error(let error):
                        print("data fetch error: \(error.localizedDescription)")
                        return (self!.dataAdapter.itemsFromData(Data([])))
                    }
                }.finally(queue: .main) { future in
                    switch future.state {
                    case .result(let adapterResult):
                        switch adapterResult {
                        case .success(let items):
                            self.moviesCache.setObject(items, key: self.moviesKey)
                            completionHandler(items)
                        case .error(let error):
                            print("data fetch error: \(error.localizedDescription)")
                            completionHandler([])
                        }
                    case .error(let err):
                        print(String(describing: err))
                        completionHandler([])
                    case .cancelled:
                        print("future is in a cancelled state")
                        completionHandler([])
                    case .unresolved:
                        print("this really cannot be if any chaining block is executed")
                        completionHandler([])
                    }
                }
            } else {
                completionHandler(movies)
            }
        }
    }
}
