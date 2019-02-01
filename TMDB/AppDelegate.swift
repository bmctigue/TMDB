//
//  AppDelegate.swift
//  TMDB
//
//  Created by Bruce McTigue on 1/7/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import UIKit
import Tiguer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appBuilder: App.Builder!
    let testingKey = "testing"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if UserDefaults.standard.string(forKey: testingKey) == nil {
            self.appBuilder = App.Builder(with: window)
        } else {
            self.appBuilder = App.Builder(with: window, testingState: TestingState.testing)
        }
        appBuilder.run()
        return true
    }
}
