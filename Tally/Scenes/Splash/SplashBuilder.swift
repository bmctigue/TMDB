//
//  SplashBuilder.swift
//  Tally
//
//  Created by Bruce McTigue on 1/9/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit

enum Splash {
    final class Builder: VCBuilder {
        
        private var window: UIWindow?
        
        init(with window: UIWindow?) {
            self.window = window
        }
        
        func run(completionHandler: VCBuilderBlock) {
            let storyboard = StoryboardFactory().create(name: "Splash")
            let controller: SplashViewController = storyboard.instantiateInitialViewController() as! SplashViewController
            controller.window = window
            completionHandler(controller)
        }
    }
}
