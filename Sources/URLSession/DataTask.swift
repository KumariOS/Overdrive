//
//  DataTask.swift
//  Overdrive
//
//  Created by Said Sikira on 11/24/16.
//
//

import Foundation
import Overdrive

open class DataTask: Task<(Data, URLResponse)> {
    
    let request: URLRequest
    weak var session: URLSession?
    
    var task: URLSessionDataTask?
    
    // MARK: Init methods
    public init(request: URLRequest, session: URLSession = .shared) {
        self.request = request
        self.session = session
        
        super.init()
        
        task = session.dataTask(with: request) { [weak self]
            (result: Result<(Data, URLResponse)>) in
            self?.finish(with: result)
        }
    }
    
    convenience init(url: URL, session: URLSession = .shared) {
        let request = URLRequest(url: url)
        self.init(request: request, session: session)
    }
    
    convenience init?(urlString: String, session: URLSession = .shared) {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let request = URLRequest(url: url)
        self.init(request: request, session: session)
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
