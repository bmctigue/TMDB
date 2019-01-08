//
//  MoviesStore.swift
//  Tally
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit

extension Movies {
    struct RemoteStore: StoreProtocol {
        func fetchData(_ request: Request, completionHandler: @escaping (Store.Result) -> Void) {
            let postData = NSData(data: "{}".data(using: String.Encoding.utf8)!)
            
            let page = request.params["page"] ?? "1"
            let urlManager = URLManager()
            let url = urlManager.fetchMoviesURL(page)
            if let url = url {
                let urlRequest = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
                urlRequest.httpMethod = "GET"
                urlRequest.httpBody = postData as Data
                
                let session = URLSession.shared
                let dataTask = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, _, error) -> Void in
                    DispatchQueue.main.async {
                        if error == nil {
                            if let data = data {
                                completionHandler(.success(data))
                            } else {
                                completionHandler(.error(.fetchDataFailed))
                            }
                        } else {
                            completionHandler(.error(.fetchDataFailed))
                        }
                    }
                })
                dataTask.resume()
            }
        }
    }
}
