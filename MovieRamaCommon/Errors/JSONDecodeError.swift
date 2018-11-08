//
//  JSONDecodeError.swift
//  MovieRamaCommon
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

public enum JSONDecodeError: Error {
    case invalidType(key: String, file: String, function: String, line: Int)
    case invalidTypeOrMissingKey(key: String, file: String, function: String, line: Int)
    
    public var errorDescription: String? {
        switch self {
        case .invalidType(_):
            return nil
        case .invalidTypeOrMissingKey(_):
            return nil
        }
    }
}
