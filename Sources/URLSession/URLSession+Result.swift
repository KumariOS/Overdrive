//
//  URLSession+Result.swift
//  Overdrive
//
//  Created by Said Sikira on 11/24/16.
//
//

import Foundation
import enum Overdrive.Result


extension URLSession {
    
    open func dataTask(with request: URLRequest,
                       completion: @escaping (Result<(Data, URLResponse)>) -> ()) ->URLSessionDataTask {
    
        return dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.error(error))
                return
            }
            
            guard
                let data = data,
                let response = response else {
                    return
            }
            
            completion(.value(data, response))
        }
    }
    
    open func dataTask(with url: URL,
                       completion: @escaping (Result<(Data, URLResponse)>) -> ()) ->URLSessionDataTask {
        let request = URLRequest(url: url)
        return dataTask(with: request, completion: completion)
    }
}
