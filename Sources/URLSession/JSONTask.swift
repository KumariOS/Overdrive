//
//  JSONTask.swift
//  Overdrive
//
//  Created by Said Sikira on 11/25/16.
//
//

import Foundation
import Overdrive

public enum JSONTaskError: Error {
    case invalidData(data: Any)
}

open class JSONTask: Task<[String: Any]> {
    
    var task: URLSessionDataTask?
    
    public init(request: URLRequest, session: URLSession = .shared) {
        super.init()
        
        self.task = session.dataTask(with: request) { [weak self] (result: Result<(Data, URLResponse)>) in
            let data = result.map { data, _ in return data }
            let json = JSONSerialization.jsonObject(with: data)
            
            self?.finish(with: json)
        }
    }
    
    // MARK: Execution
    
    open override func run() {
        task?.resume()
    }
    
    open override func cancel() {
        task?.cancel()
        super.cancel()
    }
}
