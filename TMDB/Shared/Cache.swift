//
//  Cache.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit
import Cache

class BaseCache {
    lazy var diskConfig = DiskConfig(name: "Floppy")
    lazy var memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)
}

final class FavoritesCache: BaseCache, CacheProtocol {
    typealias CacheObject = Set<Int>
    
    private var appStateManager: AppStateManager
    
    init(_ appStateManager: AppStateManager) {
        self.appStateManager = appStateManager
    }
    
    lazy var storage = try? Storage(
        diskConfig: diskConfig,
        memoryConfig: memoryConfig,
        transformer: TransformerFactory.forCodable(ofType: CacheObject.self)
    )
    
    func setObject<CacheObject>(_ object: CacheObject, key: String) {
        guard appStateManager.getCachingState() == .caching else {
            return
        }
        try? storage?.setObject(object as! FavoritesCache.CacheObject, forKey: key)
    }
    
    func getObject<CacheObject>(_ key: String) -> CacheObject {
        let object = try? storage?.object(forKey: key)
        return object as! CacheObject
    }
    
    func removeObject(_ key: String) {
        try? storage?.removeObject(forKey: key)
    }
}

final class MoviesCache: BaseCache, CacheProtocol {
    typealias CacheObject = [Movie]
    
    private var appStateManager: AppStateManager
    
    init(_ appStateManager: AppStateManager) {
        self.appStateManager = appStateManager
    }
    
    lazy var storage = try? Storage(
        diskConfig: diskConfig,
        memoryConfig: memoryConfig,
        transformer: TransformerFactory.forCodable(ofType: CacheObject.self)
    )
    
    func setObject<CacheObject>(_ object: CacheObject, key: String) {
        guard appStateManager.getCachingState() == .caching else {
            return
        }
        try? storage?.setObject(object as! MoviesCache.CacheObject, forKey: key)
    }
    
    func getObject<CacheObject>(_ key: String) -> CacheObject {
        let object = try? storage?.object(forKey: key)
        return object as! CacheObject
    }
    
    func removeObject(_ key: String) {
        try? storage?.removeObject(forKey: key)
    }
}
