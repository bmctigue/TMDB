//
//  SplashBuilderTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 2/1/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB

class SplashBuilderTests: XCTestCase {

    func testSplashBuilder() {
        var resultViewController: UIViewController?
        let expectation = self.expectation(description: "fetchSplash")
        let window = UIWindow(frame: UIScreen.main.bounds)
        let builder = Splash.Builder(with: window)
        builder.run { viewController in
            resultViewController = viewController
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(resultViewController)
        XCTAssert(resultViewController!.isKind(of: UIViewController.self))
    }
}
