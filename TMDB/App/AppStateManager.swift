//
//  AppStateManager.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/12/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import Foundation

final class AppStateManager {
    
    static let shared = AppStateManager()
    private init() {}
    
    private var testingState = TestingState.notTesting
    
    func updateTestingState(_ state: TestingState) {
        self.testingState = state
    }
    
    func getStateState() -> TestingState {
        return testingState
    }
}
