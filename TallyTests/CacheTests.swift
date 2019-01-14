//
//  CacheTests.swift
//  TallyTests
//
//  Created by Bruce McTigue on 1/8/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import Tally

class CacheTests: XCTestCase {
    
    override func setUp() {
        AppStateManager.shared.updateCachingState(.caching)
    }
    
    func testAddObjectToFavoritesCache() {
        let key = "favorites"
        let testInt = 5
        let set: Set<Int> = [testInt]
        let favoritesCache = FavoritesCache()
        favoritesCache.setObject(set, key: key)
        let cachedSet: Set<Int> = favoritesCache.getObject(key)
        XCTAssert(cachedSet.contains(testInt))
    }
    
    func testRemoveObjectFromFavoritesCache() {
        let key = "favorites"
        let testInt = 5
        let set: Set<Int> = [testInt]
        let favoritesCache = FavoritesCache()
        favoritesCache.setObject(set, key: key)
        favoritesCache.removeObject(key)
        XCTAssertNil(favoritesCache.getObject(key))
    }
}
