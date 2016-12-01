//
//  TestCaseTask.swift
//  Overdrive
//
//  Created by Said Sikira on 12/1/16.
//
//

import Overdrive

// MARK: - TestCaseTask

/// Special `Task<T>` subclass that is used in test enviroment
/// in cases where task result should be defined at initialization
/// stage.
public class TestCaseTask<T>: Task<T> {
    
    /// Test result
    let testResult: Result<T>
    
    
    /// Create new instance with specified result
    ///
    /// - Parameter result: Any `Result<T>`
    init(withResult result: Result<T>) {
        self.testResult = result
    }
    
    override public func run() {
        finish(with: testResult)
    }
}

/// Returns a `Task<T>` instance that will finish with
/// specified result
///
/// - Parameter result: `Result<T>`
/// - Returns: `Task<T>` instance
public func anyTask<T>(withResult result: Result<T>) -> Task<T> {
    return TestCaseTask(withResult: result)
}
