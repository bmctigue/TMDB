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
    final class Service<Model: Codable, Adapter: DataAdapterProtocol>: ServiceProtocol {
        
        private var store: StoreProtocol
        private var dataAdapter: Adapter
        private var cacheKey: String
        private var models: [Model] = []
        private lazy var cache = BaseCache<[Model]>()
        
        init(_ store: StoreProtocol, dataAdapter: Adapter, cacheKey: String) {
            self.store = store
            self.dataAdapter = dataAdapter
            self.cacheKey = cacheKey
            self.models = cache.getObject(cacheKey) ?? []
        }
        
        func fetchItems(_ request: Request, urlGenerator: URLGenerator, completionHandler: @escaping ([Any]) -> Void) {
            let force = request.params[Constants.forceKey]
            if models.isEmpty || force != nil {
                if let url = urlGenerator.url() {
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
                                self.cache.setObject(items, key: self.cacheKey)
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
                completionHandler(models)
            }
        }
        
        func updateCacheTestingState(_ testingState: TestingState) {
            self.cache.updateTestingState(testingState)
        }
    }
}
