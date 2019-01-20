//
//  AppDelegate.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/7/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var appBuilder = App.Builder(with: window)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        appBuilder.run()
        return true
    }
}
