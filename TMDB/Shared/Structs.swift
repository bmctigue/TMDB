//
//  Structs.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/1/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

struct Request {
    var params: [String: String]
    init(_ params: [String: String] = [:]) {
        self.params = params
    }
}

struct Response<Model> {
    let models: [Model]
}
