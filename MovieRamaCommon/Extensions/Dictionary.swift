//
//  Dictionary.swift
//  MovieRamaCommon
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    public func list(key: String,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line) throws -> [[String: Any]] {
        
        guard let value = self[key] as? [[String: Any]] else {
            throw JSONDecodeError.invalidTypeOrMissingKey(key: key,
                                                          file: file,
                                                          function: function,
                                                          line: line
            )
        }
        
        return value
    }
    
    public func string(key: String,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line) throws -> String {
        
        guard let value = self[key] as? String else {
            throw JSONDecodeError.invalidTypeOrMissingKey(key: key,
                                                          file: file,
                                                          function: function,
                                                          line: line
            )
        }
        
        return value
    }
    
    public func uuid(key: String,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line) throws -> UUID {
        
        guard let value = UUID(uuidString: try string(key: key, file: file, function: function, line: line)) else {
            throw JSONDecodeError.invalidTypeOrMissingKey(key: key,
                                                          file: file,
                                                          function: function,
                                                          line: line
            )
        }
        
        return value
    }
    
    public func url(key: String,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) throws -> URL {
        
        guard let value = URL(string: try string(key: key, file: file, function: function, line: line)) else {
            throw JSONDecodeError.invalidTypeOrMissingKey(key: key,
                                                          file: file,
                                                          function: function,
                                                          line: line
            )
        }
        
        return value
    }
    
    public func bool(key: String,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line) throws -> Bool {
        
        guard let value = self[key] as? Bool else {
            throw JSONDecodeError.invalidTypeOrMissingKey(key: key,
                                                          file: file,
                                                          function: function,
                                                          line: line
            )
        }
        return value
    }
    
    public func int(key: String,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) throws -> Int {
        
        guard let value = (self[key] as? NSNumber)?.intValue else {
            throw JSONDecodeError.invalidTypeOrMissingKey(key: key,
                                                          file: file,
                                                          function: function,
                                                          line: line
            )
        }
        
        return value
    }
    
    public func float(key: String,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) throws -> Float {
        
        guard let value = (self[key] as? NSNumber)?.floatValue else {
            throw JSONDecodeError.invalidTypeOrMissingKey(key: key,
                                                          file: file,
                                                          function: function,
                                                          line: line
            )
        }
        
        return value
    }
    
    public func double(key: String,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line) throws -> Double {
        
        guard let value = (self[key] as? NSNumber)?.doubleValue else {
            throw JSONDecodeError.invalidTypeOrMissingKey(key: key,
                                                          file: file,
                                                          function: function,
                                                          line: line
            )
        }
        
        return value
    }
    
    public func date(key: String,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line) throws -> Date {
        
        let rawValue = try self.double(key: key,
                                       file: file,
                                       function: function,
                                       line: line)
        
        if rawValue > Date.distantFuture.timeIntervalSince1970 {
            return Date.distantFuture
        }
        
        if rawValue < Date.distantPast.timeIntervalSince1970 {
            return Date.distantPast
        }
        
        return Date(timeIntervalSince1970: rawValue)
    }
}
