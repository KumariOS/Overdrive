//
//  RetryTests.swift
//  Overdrive
//
//  Created by Said Sikira on 8/26/16.
//  Copyright © 2016 Said Sikira. All rights reserved.
//

import XCTest
import TestSupport

@testable import Overdrive

class RetryTestTask: Task<Int> {
    fileprivate(set) var failCount: Int
    
    init(failCount: Int) {
        self.failCount = failCount
    }
    
    override func run() {
        if failCount == 0 {
            finish(with: .value(1))
        } else {
            failCount -= 1
            finish(with: .error(TaskError.fail("Failed with retry count \(failCount)")))
        }
    }
}

class RetryTests: XCTestCase {
    
    func testRetryCount() {
        let retryTestTask = RetryTestTask(failCount: 5)
        
        XCTAssertEqual(retryTestTask.retryCount, 0)
        
        retryTestTask.retry(3)
        
        XCTAssertEqual(retryTestTask.retryCount, 3)
    }
    
    func testReduceRetryCount() {
        let retryTestTask = RetryTestTask(failCount: 3)
        retryTestTask.retry(3)
        
        do {
            try retryTestTask.decreaseRetryCount()
            XCTAssertEqual(retryTestTask.retryCount, 2, "Retry count after decreasing incorrect")
        } catch {
            XCTFail("Decrease count failed with error \(error)")
        }
    }
    
    func testRetry() {
        let retryExpectation = expectation(description: "Task should be retried")
        
        let retryTestTask = RetryTestTask(failCount: 5)
        
        // Set retry count
        retryTestTask.retry(5)
        
        // Set onValue and onError
        retryTestTask
            .onValue { value in
                XCTAssertEqual(retryTestTask.retryCount, 0, "Retry count is not correct")
                retryExpectation.fulfill()
            }.onError { error in
                XCTFail("Task should not fail with error \(error)")
        }
        
        TaskQueue(qos: .default).add(task: retryTestTask)
        
        waitForExpectations(timeout: 0.2, handler: nil)
    }
}
