//
//  PhotoTests.swift
//  Overdrive
//
//  Created by Said Sikira on 12/11/16.
//
//

import XCTest
import Overdrive
import TestSupport

@testable import URLSession

#if os(iOS) || os(tvOS) || os(watchOS)
    import class UIKit.UIImage
    typealias Image = UIImage
#elseif os(OSX)
    import class AppKit.NSImage
    typealias Image = NSImage
#endif

/// Photo tests are only used on Apple platforms where UIKit is available

#if os(iOS) || os(tvOS) || os(watchOS) || os(OSX)
    
    class PhotoTests: XCTestCase {
        
        enum PhotoTestsError: Error {
            case invalidData
        }
        
        func testFetchPhoto() {
            let testExpectation = expectation(description: "DataTask photo download expectation")
            
            let url = URL(string: "https://httpbin.org/image/png")!
            let task = DataTask(url: url)
            
            task
                .onValue { data, response in
                    guard let _ = Image(data: data) else {
                        throw PhotoTestsError.invalidData
                    }
                    
                    testExpectation.fulfill()
                }.onError { error in
                    XCTFail(String(describing: error))
            }
            
            TaskQueue.main.add(task: task)
            
            waitForExpectations(timeout: 1, handler: nil)
        }
    }
    
#endif
