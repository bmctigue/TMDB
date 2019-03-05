//
//  LocalDataUrlGenerator.swift
//  RicosCafe
//
//  Created by Bruce McTigue on 2/1/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

extension Tiguer {
    open class LocalDataUrlGenerator: URLGenerator {
        
        private lazy var components: URLComponents = URLComponents()
        
        public init(_ request: Request) {
            self.components.host = "www.google.com"
            self.components.path = ""
            self.components.scheme = "https"
        }
        
        open func url() -> URL? {
            return components.url
        }
    }
}
