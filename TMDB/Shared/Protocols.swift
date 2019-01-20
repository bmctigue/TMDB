//
//  Protocols.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/26/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Promis

typealias VCBuilderBlock = ((UIViewController) -> Void)
typealias TabBarBuilderBlock = ((UITabBarController) -> Void)

protocol BaseBuilder: class {
    func run()
}

protocol VCBuilder: class {
    func run(completionHandler: VCBuilderBlock)
}

protocol StoreProtocol {
    func fetchData(_ request: Request, url: URL?) -> Future<Store.Result>
}

protocol DataAdapterProtocol {
    associatedtype Model
    func itemsFromData(_ data: Data, completionHandler: @escaping (DataAdapter.Result<Model>) -> Void)
}

protocol MoviesDataAdapterProtocol {
    func itemsFromData(_ data: Data) -> Future<MovieDataAdapter.Result>
}

protocol ServiceProtocol: class {
    associatedtype Model
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
    func getObject<CacheObject>(_ key: String) -> CacheObject
    func removeObject(_ key: String)
}

protocol NetworkSession {
    func loadData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void)
}