//
//  DataTask.swift
//  Overdrive
//
//  Created by Said Sikira on 11/24/16.
//
//

import Foundation
import Overdrive

/// Provides interface for loading requests
open class DataTask: Task<(Data, URLResponse)> {
    
    static var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()
    
    /// `URLRequest` object
    let request: URLRequest
    
    /// `URLSession` object
    weak var session: URLSession?
    
    var task: URLSessionDataTask?
    
    // MARK: Init methods
    
    /// Create new instance of `DataTask`
    ///
    /// - Parameters:
    ///   - request: URL request
    ///   - session: `URLSession` object, defaults to shared url session
    public init(request: URLRequest, session: URLSession = DataTask.session) {
        self.request = request
        self.session = session
        
        super.init()
        
        task = self.session?.dataTask(with: request) { [weak self]
            (result: Result<(Data, URLResponse)>) in
            self?.finish(with: result)
        }
    }
    
    
    /// Create `DataTask` instance with `URL` object
    ///
    /// - Parameters:
    ///   - url: `URL`
    ///   - session: `URLSession` object, defaults to shared url session
    convenience init(url: URL, session: URLSession = DataTask.session) {
        let request = URLRequest(url: url)
        self.init(request: request, session: session)
    }
    
    /// Create `DataTask` instance with url string
    ///
    /// - Parameters:
    ///   - urlString: URL `String` object
    ///   - session: `URLSession` object, defaults to shared url session
    ///
    /// - Returns: Optional `DataTask` instance (nil if url string is invalid)
    convenience init?(urlString: String, session: URLSession = DataTask.session) {
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
