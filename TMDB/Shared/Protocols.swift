//
//  Protocols.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Promis
import Tiguer

protocol MoviesDataAdapterProtocol {
    func itemsFromData(_ data: Data) -> Future<MovieDataAdapter.Result>
}

protocol ServiceProtocol: class {
    associatedtype Model
    var moviesCache: MoviesCache { get }
    func fetchItems(_ request: Request, completionHandler: @escaping ([Model]) -> Void)
}

protocol InteractorProtocol: class {
    func fetchItems(_ request: Request)
}

protocol PresenterProtocol {
    associatedtype Model
    associatedtype ViewModel
}

protocol CacheProtocol {
    associatedtype CacheObject
    func setObject<CacheObject>(_ object: CacheObject, key: String)
    func getObject<CacheObject>(_ key: String) -> CacheObject?
    func removeObject(_ key: String)
}
