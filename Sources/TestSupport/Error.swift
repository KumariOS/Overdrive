//
//  Error.swift
//  Overdrive
//
//  Created by Said Sikira on 12/1/16.
//
//

import Foundation

/*
 Defines errors that can be used in test environment
 */
public enum TaskError: Error {
    
    /// Regular error with message
    case fail(String )
    
    /// Type erased combined errors
    case combined([Error])
}
