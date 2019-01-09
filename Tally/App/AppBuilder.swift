//
//  AppBuilder.swift
//  Tally
//
//  Created by Bruce McTigue on 11/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit

enum App {
    final class Builder: BaseBuilder {
        
        private var window: UIWindow?
        private (set) var splashBuilder: Splash.Builder
        
        init(with window: UIWindow?) {
            self.window = window
            self.splashBuilder = Splash.Builder(with: window)
        }
        
        func getWindow() -> UIWindow? {
            return self.window
        }
        
        func run() {
            splashBuilder.run { [weak self] viewController in
                self?.window?.rootViewController = viewController
                self?.window?.makeKeyAndVisible()
            }
        }
    }
}
