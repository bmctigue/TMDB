//
//  Cache.swift
//  Tiguer
//
//  Created by Bruce McTigue on 2/4/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation
import Cache

public final class BaseCache<CacheObject: Codable>: CacheProtocol {
    private lazy var diskConfig = DiskConfig(name: "Floppy")
    private lazy var memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)
    private var testingState: TestingState = .notTesting
    
    public init() {}
    
    private lazy var storage = try? Storage(
        diskConfig: diskConfig,
        memoryConfig: memoryConfig,
        transformer: TransformerFactory.forCodable(ofType: CacheObject.self)
    )
    
    public func setObject<CacheObject>(_ object: CacheObject, key: String) {
        guard testingState == .notTesting else {
            return
        }
        try? storage?.setObject(object as! BaseCache.CacheObject, forKey: key)
    }
    
    public func getObject<CacheObject>(_ key: String) -> CacheObject? {
        let object = try? storage?.object(forKey: key)
        return object as? CacheObject
    }
    
    public func removeObject(_ key: String) {
        try? storage?.removeObject(forKey: key)
    }
    
    public func updateTestingState(_ testingState: TestingState) {
        self.testingState = testingState
    }
}

