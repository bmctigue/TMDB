//
//  AppDelegate.swift
//  Tally
//
//  Created by Bruce McTigue on 1/7/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let appBuilder = Builder.App(with: window)
        appBuilder.run()
        return true
    }
}
