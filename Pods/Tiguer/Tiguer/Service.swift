//
//  Service.swift
//  Tiguer
//
//  Created by Bruce McTigue on 2/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation
import Promis

extension Tiguer {
    open class Service<Model: Codable, Adapter: DataAdapterProtocol>: ServiceProtocol {
        
        private var store: StoreProtocol
        private var dataAdapter: Adapter
        private var cacheKey: String
        private var models: [Model] = []
        private lazy var cache = BaseCache<[Model]>()
        
        public init(_ store: StoreProtocol, dataAdapter: Adapter, cacheKey: String) {
            self.store = store
            self.dataAdapter = dataAdapter
            self.cacheKey = cacheKey
            self.models = cache.getObject(cacheKey) ?? []
        }
        
        public func fetchItems(_ request: Request, url: URL, completionHandler: @escaping ([Any]) -> Void) {
            let force = request.params[Tiguer.Constants.forceKey]
            if models.isEmpty || force != nil {
                store.fetchData(url).thenWithResult { [weak self] (storeResult: Store.Result) -> Future<DataAdapterResult.Result<Model>> in
                    switch storeResult {
                    case .success(let data):
                        return (self!.dataAdapter.itemsFromData(data) as! Future<DataAdapterResult.Result<Model>>)
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
                completionHandler(models)
            }
        }
        
        public func updateCacheTestingState(_ testingState: TestingState) {
            self.cache.updateTestingState(testingState)
        }
    }
}
