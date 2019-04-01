//
//  Cache.swift
//  Tiguer
//
//  Created by Bruce McTigue on 2/4/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

open class BaseCache: CacheProtocol {
    public typealias CacheObject = Int
    
    private var testingState: TestingState = .notTesting
    private var storage: NSCache<NSString, AnyObject>
    
    public init() {
        self.storage = NSCache<NSString, AnyObject>()
    }
    
    public func setObject<CacheObject>(_ object: CacheObject, key: NSString) {
        guard testingState == .notTesting else {
            return
        }
        storage.setObject(object as AnyObject, forKey: key)
    }
    
    public func getObject<CacheObject>(_ key: NSString) -> CacheObject? {
        let object = storage.object(forKey: key)
        return object as? CacheObject
    }
    
    public func removeObject(_ key: NSString) {
        storage.removeObject(forKey: key)
    }
    
    public func updateTestingState(_ testingState: TestingState) {
        self.testingState = testingState
    }
}
