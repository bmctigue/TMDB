//
//  StoryboardFactoryTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 2/1/19.
//  Copyright © 2019 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB

class StoryboardFactoryTests: XCTestCase {
    
    func testStoryBoardFactory() {
        let factory = StoryboardFactory()
        let storyboard = factory.create(name: "LaunchScreen")
        XCTAssert(storyboard.isKind(of: UIStoryboard.self))
    }
}
