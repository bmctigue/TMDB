//
//  AppStateManager.swift
//  Tally
//
//  Created by Bruce McTigue on 1/12/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

final class AppStateManager {
    
    static let shared = AppStateManager()
    private init() {}
    
    private var cachingState = CachingState.caching
    
    func updateCachingState(_ state: CachingState) {
        self.cachingState = state
    }
    
    func getCachingState() -> CachingState {
        return cachingState
    }
}
