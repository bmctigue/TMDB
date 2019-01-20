//
//  DynamicValueTests.swift
//  TMDBTests
//
//  Created by Bruce McTigue on 12/25/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import TMDB

class DynamicValueTests: XCTestCase {
    
    let values = [1, 2, 3]
    var newValues: [Int] = []
    var notifyValues: [Int] = [1, 2, 3, 4, 5]
    
    override func setUp() {
        newValues = []
    }

    func testAddObserver() {
        let expectation = self.expectation(description: "addObserver")
        let dynamic = DynamicValue(values)
        dynamic.addObserver(self) { [weak self] in
            self?.newValues = dynamic.value
            expectation.fulfill()
        }
        dynamic.value = [1, 2, 3, 4]
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(newValues.count == 4)
        
    }
    
    func testAddObserverAndNotify() {
        let expectation = self.expectation(description: "addObserverAndNotify")
        let dynamic = DynamicValue(values)
        newValues = values
        dynamic.addAndNotify(observer: self) { [weak self] in
            if self?.newValues != dynamic.value {
                self?.newValues = dynamic.value
                expectation.fulfill()
            }
        }
        dynamic.value = [1, 2, 3, 4, 5]
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssert(newValues.count == 5)
    }
    
    func testCleanup() {
        
        class ClassUnderTest: DynamicValue<Any> {
            var deinitCalled: (() -> Void)?
            deinit { deinitCalled?() }
        }
        
        let exp = expectation(description: "exp")
        
        var instance: ClassUnderTest? = ClassUnderTest(newValues.self)
        
        instance?.deinitCalled = {
            exp.fulfill()
        }
        
        DispatchQueue.global(qos: .background).async {
            instance = nil
        }
        
        waitForExpectations(timeout: 5)
    }

}
