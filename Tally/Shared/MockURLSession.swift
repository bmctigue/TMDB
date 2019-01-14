//
//  MockURLSession.swift
//  Tally
//
//  Created by Bruce McTigue on 1/14/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

extension URLSession: NetworkSession {
    func loadData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: urlRequest) { (data, _, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}

class MockNetworkSession: NetworkSession {
    var data: Data?
    var error: Error?
    
    func loadData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}
