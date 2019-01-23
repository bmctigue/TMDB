//
//  MoviesLocalStore.swift
//  TMDB
//
//  Created by Bruce McTigue on 12/27/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Promis

struct LocalStore: StoreProtocol {

    private var assetName: String
    
    init(_ assetName: String) {
        self.assetName = assetName
    }
    
    func fetchData(_ url: URL) -> Future<Store.Result> {
        let promise = Promise<Store.Result>()
        if let asset = NSDataAsset(name: assetName, bundle: Bundle.main) {
            promise.setResult(.success(asset.data))
        } else {
            promise.setError(StoreError.fetchDataFailed)
        }
        return promise.future
    }
}
