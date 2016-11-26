//
//  JSONSerialization+Result.swift
//  Overdrive
//
//  Created by Said Sikira on 11/25/16.
//
//

import Foundation
import enum Overdrive.Result

extension JSONSerialization {
    open class func jsonObject(with result: Result<Data>) -> Result<[String: Any]> {
        return result.map { data in
            do {
                let rawJSON = try jsonObject(with: data, options: [])
                guard let dictionary = rawJSON as? [String: Any] else {
                    throw JSONTaskError.invalidData(data: rawJSON)
                }
                
                return dictionary
            } catch {
                throw error
            }
        }
    }
}
