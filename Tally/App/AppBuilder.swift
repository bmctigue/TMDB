//
//  AppBuilder.swift
//  Tally
//
//  Created by Bruce McTigue on 11/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit

enum Builder {
    final class App: BaseBuilder {
        
        static let moviesAssetName = "moviesJson"
        private static let moviesTitle = "Movies"
        
        private var window: UIWindow?
        private (set) var moviesBuilder: Movies.Builder
        
        init(with window: UIWindow?) {
            self.window = window
            let store = Movies.RemoteStore()
            self.moviesBuilder = Movies.Builder(with: Builder.App.moviesTitle, store: store, state: .all)
        }
        
        func getWindow() -> UIWindow? {
            return self.window
        }
        
        func run() {
            moviesBuilder.run { [weak self] viewController in
                self?.window?.rootViewController = viewController
                self?.window?.makeKeyAndVisible()
            }
        }
    }
}
