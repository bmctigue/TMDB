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
        
        private let session: NetworkSession
        
        init(session: NetworkSession = URLSession.shared) {
            self.session = session
        }
        
        func fetchData(_ request: Request, url: URL? = nil, completionHandler: @escaping (Store.Result) -> Void) {
            let postData = NSData(data: "{}".data(using: String.Encoding.utf8)!)
            if let url = url {
                let urlRequest = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
                urlRequest.httpMethod = "GET"
                urlRequest.httpBody = postData as Data
                
                session.loadData(with: urlRequest as URLRequest) { (data, error) in
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
                }
            } else {
                completionHandler(.success(Data([])))
            }
        }
    }
}
