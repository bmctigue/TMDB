//
//  MoviesStore.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit
import Promis

extension Movies {
    struct RemoteStore: StoreProtocol {
        
        private let session: URLSession
        
        init(session: URLSession = URLSession.shared) {
            self.session = session
        }
        
        func fetchData(_ request: Request, url: URL?) -> Future<Store.Result> {
            let promise = Promise<Store.Result>()
            let postData = NSData(data: "{}".data(using: String.Encoding.utf8)!)
            if let url = url {
                let urlRequest = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
                urlRequest.httpMethod = "GET"
                urlRequest.httpBody = postData as Data
                
                let dataTask = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, _, error) -> Void in
                    DispatchQueue.main.async {
                        if error == nil {
                            if let data = data {
                                promise.setResult(.success(data))
                            } else {
                                promise.setError(StoreError.fetchDataFailed)
                            }
                        } else {
                            promise.setError(StoreError.fetchDataFailed)
                        }
                    }
                })
                dataTask.resume()
            } else {
                promise.setResult(.success(Data([])))
            }
            return promise.future
        }
    }
}
