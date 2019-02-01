//
//  MoviesService.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Promis
import Tiguer

extension Movies {
    final class Service<Adapter: DataAdapterProtocol>: ServiceProtocol {
        
        private var store: StoreProtocol
        private var dataAdapter: Adapter
        private var movies: [Movie] = []
        private (set) var moviesCache: MoviesCache
        
        let moviesKey = "movies"
        
        init(_ store: StoreProtocol, dataAdapter: Adapter, testingState: TestingState = TestingState.notTesting) {
            self.store = store
            self.dataAdapter = dataAdapter
            self.moviesCache = MoviesCache(testingState)
            self.movies = moviesCache.getObject(moviesKey) ?? []
        }
        
        func fetchItems(_ request: Request, completionHandler: @escaping ([Any]) -> Void) {
            typealias Model = Movie
            let force = request.params[Constants.forceKey]
            let dataUrlGenerator = MoviesDataUrl(request)
            if movies.isEmpty || force != nil {
                if let url = dataUrlGenerator.url() {
                    store.fetchData(url).thenWithResult { [weak self] (storeResult: Store.Result) -> Future<DataAdapter.Result<Model>> in
                        switch storeResult {
                        case .success(let data):
                            return (self!.dataAdapter.itemsFromData(data) as! Future<DataAdapter.Result<Model>>)
                        }
                    }.finally(queue: .main) { future in
                        switch future.state {
                        case .result(let adapterResult):
                            switch adapterResult {
                            case .success(let items):
                                self.moviesCache.setObject(items, key: self.moviesKey)
                                completionHandler(items)
                            }
                        case .error(let error):
                            print("data fetch error: \(error.localizedDescription)")
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
                    print("data fetch error: url was not valid")
                    completionHandler([])
                }
            } else {
                completionHandler(movies)
            }
        }
    }
}
