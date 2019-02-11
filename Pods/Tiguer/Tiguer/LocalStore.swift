//
//  LocalStore.swift
//  Tiguer
//
//  Created by Bruce McTigue on 12/27/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation
import Promis

public struct LocalStore: StoreProtocol {
    
    private var assetName: String
    
    public init(_ assetName: String) {
        self.assetName = assetName
    }
    
    public func fetchData(_ url: URL, bundle: Bundle) -> Future<Store.Result> {
        let promise = Promise<Store.Result>()
        if let asset = NSDataAsset(name: assetName, bundle: bundle) {
            promise.setResult(.success(asset.data))
        } else {
            promise.setError(StoreError.fetchDataFailed)
        }
        return promise.future
    }
}
