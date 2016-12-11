//
//  DataTaskTests.swift
//  Overdrive
//
//  Created by Said Sikira on 11/24/16.
//
//

import XCTest
import Overdrive
import TestSupport

@testable import URLSession

class DataTaskTests: XCTestCase {
    
    enum DataTaskTestsError: Error {
        case invalidData(Any)
    }
    
    func testDataTask() {
        let testExpectation = expectation(description: "DataTask expectation")
        
        let url = URL(string: "https://httpbin.org/get")!
        let task = DataTask(url: url)
        
        task
            .onValue { data, response in
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    guard let document = json as? [String: Any] else {
                        throw DataTaskTestsError.invalidData(json)
                    }
                    
                    let url = document["url"] as? String
                    
                    XCTAssertEqual(url, "https://httpbin.org/get")
                    testExpectation.fulfill()
                }
            }.onError { error in
                XCTFail(String(describing: error))
        }
        
        TaskQueue.main.add(task: task)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
