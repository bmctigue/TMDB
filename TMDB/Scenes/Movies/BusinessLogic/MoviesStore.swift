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
        
        func fetchData(_ request: Request, url: URL) -> Future<Store.Result> {
            var url = url
            let promise = Promise<Store.Result>()
            url = addParametersToUrl(url, request: request)
            
            let postData = NSData(data: "{}".data(using: String.Encoding.utf8)!)
            
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
            return promise.future
        }
        
        func addParametersToUrl(_ url: URL, request: Request) -> URL {
            var urlComponents = URLComponents(string: url.absoluteString)
            var queryItems = [URLQueryItem]()
            for (key, value) in request.params {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            urlComponents = URLComponents(string: url.absoluteString)
            urlComponents?.queryItems = queryItems
            return urlComponents?.url ?? url
        }
    }
}
