//
//  MoviesService.swift
//  Tally
//
//  Created by Bruce McTigue on 12/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit

extension Movies {
    final class Service<Adapter: MoviesDataAdapterProtocol>: ServiceProtocol {
        
        private var store: StoreProtocol
        private var dataAdapter: Adapter
        private var movies: [Movie] = []
        lazy var moviesCache = MoviesCache()
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
                store.fetchData(request, url: url) { [weak self] dataResult in
                    switch dataResult {
                    case .success(let data):
                        self?.itemsFromData(data: data, completionHandler: completionHandler)
                    case .error(let error):
                        print("data fetch error: \(error.localizedDescription)")
                        completionHandler([])
                    }
                }
            } else {
                completionHandler(movies)
            }
        }
        
        private func itemsFromData(data: Data, completionHandler: @escaping ([Any]) -> Void) {
            self.dataAdapter.itemsFromData(data) { adapterResult in
                switch adapterResult {
                case .success(let items):
                    self.moviesCache.setObject(items, key: self.moviesKey)
                    completionHandler(items)
                case .error(let error):
                    print("adapter conversion error for data: \(error.localizedDescription)")
                    completionHandler([])
                }
            }
        }
    }
}
