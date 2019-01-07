//
//  AppBuilderTests.swift
//  TallyTests
//
//  Created by Bruce McTigue on 11/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import Tally

class AppBuilderTests: XCTestCase {
    
    var buildersCount = 0
    
    func testAppBuilder() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let builder = Builder.App(with: window)
        builder.run()
        buildersCount = builder.configureBuilders().count
        XCTAssert(buildersCount > 0)
    }
}
