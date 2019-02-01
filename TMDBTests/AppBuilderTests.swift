//
//  AppBuilderTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 11/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB
@testable import Tiguer

class AppBuilderTests: XCTestCase {
    
    var buildersCount = 0
    
    func testAppBuilder() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let builder = App.Builder(with: window, testingState: TestingState.testing)
        builder.run()
        XCTAssert(builder.getWindow() != nil)
    }
}
