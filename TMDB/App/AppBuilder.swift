//
//  AppBuilder.swift
//  TMDB
//
//  Created by Bruce McTigue on 11/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Tiguer

enum App {
    final class Builder: BaseBuilder {
        
        private var window: UIWindow?
        private var builder: VCBuilder
        private var testingState: TestingState
        
        init(with window: UIWindow?, testingState: TestingState = TestingState.notTesting) {
            self.window = window
            self.testingState = testingState
            switch testingState {
            case .notTesting:
                self.builder = Splash.Builder(with: window)
            case .testing:
                let store = Movies.RemoteStore()
                self.builder = Movies.Builder(with: Movies.Builder.moviesTitle, store: store, state: .all)
            }
        }
        
        func getWindow() -> UIWindow? {
            return self.window
        }
        
        func run() {
            builder.run { [weak self] viewController in
                self?.window?.rootViewController = viewController
                self?.window?.makeKeyAndVisible()
            }
        }
    }
}
